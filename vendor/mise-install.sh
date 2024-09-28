#!/bin/sh
set -eu

#region logging setup
if [ "${MISE_DEBUG-}" = "true" ] || [ "${MISE_DEBUG-}" = "1" ]; then
	debug() {
		echo "$@" >&2
	}
else
	debug() {
		:
	}
fi

if [ "${MISE_QUIET-}" = "1" ] || [ "${MISE_QUIET-}" = "true" ]; then
	info() {
		:
	}
else
	info() {
		echo "$@" >&2
	}
fi

error() {
	echo "$@" >&2
	exit 1
}
#endregion

#region environment setup
get_os() {
	os="$(uname -s)"
	if [ "$os" = Darwin ]; then
		echo "macos"
	elif [ "$os" = Linux ]; then
		echo "linux"
	else
		error "unsupported OS: $os"
	fi
}

get_arch() {
	musl=""
	if type ldd >/dev/null 2>/dev/null; then
		libc=$(ldd /bin/ls | grep 'musl' | head -1 | cut -d ' ' -f1)
		if [ -n "$libc" ]; then
			musl="-musl"
		fi
	fi
	arch="$(uname -m)"
	if [ "$arch" = x86_64 ]; then
		echo "x64$musl"
	elif [ "$arch" = aarch64 ] || [ "$arch" = arm64 ]; then
		echo "arm64$musl"
	elif [ "$arch" = armv7l ]; then
		echo "armv7$musl"
	else
		error "unsupported architecture: $arch"
	fi
}

shasum_bin() {
	if command -v shasum >/dev/null 2>&1; then
		echo "shasum"
	elif command -v sha256sum >/dev/null 2>&1; then
		echo "sha256sum"
	else
		error "mise install requires shasum or sha256sum but neither is installed. Aborting."
	fi
}

get_checksum() {
	version=$1
	os="$(get_os)"
	arch="$(get_arch)"
	url="https://github.com/jdx/mise/releases/download/${version}/SHASUMS256.txt"

	# For current version use static checksum otherwise
	# use checksum from releases
	if [ "$version" = "v2024.9.11" ]; then
		checksum_linux_x86_64="be6988a5e1c4db9cef4eaf83f8ab9bc84be3f1903acf5f13f21729ecf871a4c6  ./mise-v2024.9.11-linux-x64.tar.gz"
		checksum_linux_x86_64_musl="2323e2f42f13cdbb5cc02ff85ffb18bed133ec5bf7bf58a34e89c95708484858  ./mise-v2024.9.11-linux-x64-musl.tar.gz"
		checksum_linux_arm64="26745459d73976b70c7340d2765bb6ac67b9ec593e219a071f846fb4e6fe54f4  ./mise-v2024.9.11-linux-arm64.tar.gz"
		checksum_linux_arm64_musl="8fc39e49955881da65b497975a3dab6e299fd7603b8f87d79c62eb316e24197c  ./mise-v2024.9.11-linux-arm64-musl.tar.gz"
		checksum_linux_armv7="86670e986c4ec01a4a2c51712a58a7090b5d182c4208f8e24992f80d25b6ba48  ./mise-v2024.9.11-linux-armv7.tar.gz"
		checksum_linux_armv7_musl="1609599b17465d234d0f1f65159833be936c5a091f8a4e13653dc8f15c92060c  ./mise-v2024.9.11-linux-armv7-musl.tar.gz"
		checksum_macos_x86_64="93da399907dec646878634ac74e6fd541dc3d3e54347bc237c1298c15ae6020a  ./mise-v2024.9.11-macos-x64.tar.gz"
		checksum_macos_arm64="04e1220c5cb86c652cba9391f1c4e11687c5d1e59073780dd83546eff24ccb21  ./mise-v2024.9.11-macos-arm64.tar.gz"

		if [ "$os" = "linux" ]; then
			if [ "$arch" = "x64" ]; then
				echo "$checksum_linux_x86_64"
			elif [ "$arch" = "x64-musl" ]; then
				echo "$checksum_linux_x86_64_musl"
			elif [ "$arch" = "arm64" ]; then
				echo "$checksum_linux_arm64"
			elif [ "$arch" = "arm64-musl" ]; then
				echo "$checksum_linux_arm64_musl"
			elif [ "$arch" = "armv7" ]; then
				echo "$checksum_linux_armv7"
			elif [ "$arch" = "armv7-musl" ]; then
				echo "$checksum_linux_armv7_musl"
			else
				warn "no checksum for $os-$arch"
			fi
		elif [ "$os" = "macos" ]; then
			if [ "$arch" = "x64" ]; then
				echo "$checksum_macos_x86_64"
			elif [ "$arch" = "arm64" ]; then
				echo "$checksum_macos_arm64"
			else
				warn "no checksum for $os-$arch"
			fi
		else
			warn "no checksum for $os-$arch"
		fi
	else
		if command -v curl >/dev/null 2>&1; then
			debug ">" curl -fsSL "$url"
			checksums="$(curl -fsSL "$url")"
		else
			if command -v wget >/dev/null 2>&1; then
				debug ">" wget -qO - "$url"
				stderr=$(mktemp)
				checksums="$(wget -qO - "$url")"
			else
				error "mise standalone install specific version requires curl or wget but neither is installed. Aborting."
			fi
		fi

		checksum="$(echo "$checksums" | grep "$os-$arch.tar.gz")"
		if ! echo "$checksum" | grep -Eq "^([0-9a-f]{32}|[0-9a-f]{64})"; then
			warn "no checksum for mise $version and $os-$arch"
		else
			echo "$checksum"
		fi
	fi
}

#endregion

download_file() {
	url="$1"
	filename="$(basename "$url")"
	cache_dir="$(mktemp -d)"
	file="$cache_dir/$filename"

	info "mise: installing mise..."

	if command -v curl >/dev/null 2>&1; then
		debug ">" curl -#fLo "$file" "$url"
		curl -#fLo "$file" "$url"
	else
		if command -v wget >/dev/null 2>&1; then
			debug ">" wget -qO "$file" "$url"
			stderr=$(mktemp)
			wget -O "$file" "$url" >"$stderr" 2>&1 || error "wget failed: $(cat "$stderr")"
		else
			error "mise standalone install requires curl or wget but neither is installed. Aborting."
		fi
	fi

	echo "$file"
}

install_mise() {
	version="${MISE_VERSION:-v2024.9.11}"
	os="$(get_os)"
	arch="$(get_arch)"
	install_path="${MISE_INSTALL_PATH:-$HOME/.local/bin/mise}"
	install_dir="$(dirname "$install_path")"
	tarball_url="https://github.com/jdx/mise/releases/download/${version}/mise-${version}-${os}-${arch}.tar.gz"

	cache_file=$(download_file "$tarball_url")
	debug "mise-setup: tarball=$cache_file"

	debug "validating checksum"
	cd "$(dirname "$cache_file")" && get_checksum "$version" | "$(shasum_bin)" -c >/dev/null

	# extract tarball
	mkdir -p "$install_dir"
	rm -rf "$install_path"
	cd "$(mktemp -d)"
	tar -xzf "$cache_file"
	mv mise/bin/mise "$install_path"
	info "mise: installed successfully to $install_path"
}

after_finish_help() {
	case "${SHELL:-}" in
	*/zsh)
		info "mise: run the following to activate mise in your shell:"
		info "echo \"eval \\\"\\\$($install_path activate zsh)\\\"\" >> \"${ZDOTDIR-$HOME}/.zshrc\""
		info ""
		info "mise: this must be run in order to use mise in the terminal"
		info "mise: run \`mise doctor\` to verify this is setup correctly"
		;;
	*/bash)
		info "mise: run the following to activate mise in your shell:"
		info "echo \"eval \\\"\\\$($install_path activate bash)\\\"\" >> ~/.bashrc"
		info ""
		info "mise: this must be run in order to use mise in the terminal"
		info "mise: run \`mise doctor\` to verify this is setup correctly"
		;;
	*/fish)
		info "mise: run the following to activate mise in your shell:"
		info "echo \"$install_path activate fish | source\" >> ~/.config/fish/config.fish"
		info ""
		info "mise: this must be run in order to use mise in the terminal"
		info "mise: run \`mise doctor\` to verify this is setup correctly"
		;;
	*)
		info "mise: run \`$install_path --help\` to get started"
		;;
	esac
}

install_mise
after_finish_help
