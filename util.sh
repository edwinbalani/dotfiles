command_exists() {
    command -v "$1" >/dev/null 2>&1
    return $?
}

is_shell () {
    command_exists "$1" && grep -Fxq "$(which "$1")" /etc/shells
    return $?
}
