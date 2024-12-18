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
	if [ "$version" = "v2024.11.26" ]; then
		checksum_linux_x86_64="3342485a44f7dbf30e9e1c5e79d2e36eb4f34dbbe77c033e2c41088cda953a31  ./mise-v2024.11.26-linux-x64.tar.gz"
		checksum_linux_x86_64_musl="322411e7d62c3d36e5244db33e454cc739fc2f9aab757b84050c0d17db2b3ff2  ./mise-v2024.11.26-linux-x64-musl.tar.gz"
		checksum_linux_arm64="183b634667010440e38c4d57fefad8ede45e24c99d751909928f382e890cbbc1  ./mise-v2024.11.26-linux-arm64.tar.gz"
		checksum_linux_arm64_musl="8d71a10b708c606c398636b400d09125f4b59e019aebd1ef5d98aa1db5540398  ./mise-v2024.11.26-linux-arm64-musl.tar.gz"
		checksum_linux_armv7="781fe199cf389bd27dd40d2d9103224a6bc67f9a311ed4c71f4e6af261f97224  ./mise-v2024.11.26-linux-armv7.tar.gz"
		checksum_linux_armv7_musl="d019e0688bdea681f70d4642a708544c5be3025cd59109b0f597c4b80cc80035  ./mise-v2024.11.26-linux-armv7-musl.tar.gz"
		checksum_macos_x86_64="a6f908f768343becd629bab5f515e4231239f097973dffedec2c05cdd34925a9  ./mise-v2024.11.26-macos-x64.tar.gz"
		checksum_macos_arm64="df65ab1b0ae554bc561d787706013a0af8fef26222a78228269cf48f041c8bf5  ./mise-v2024.11.26-macos-arm64.tar.gz"

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
			checksums="$(curl --compressed -fsSL "$url")"
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
	version="${MISE_VERSION:-v2024.11.26}"
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
