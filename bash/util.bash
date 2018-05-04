# Helpful functions grafted from zsh
# These are used in alias.bash

git_current_branch () {
	local ref
	ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null) 
	local ret=$? 
	if [[ $ret != 0 ]]
	then
		[[ $ret = 128 ]] && return
		ref=$(command git rev-parse --short HEAD 2> /dev/null)  || return
	fi
	echo ${ref#refs/heads/}
}

_git_log_prettily () {
        if ! [ -z $1 ]
        then
                git log --pretty=$1
        fi
}

decode64 () {
	if [[ $# -eq 0 ]]
	then
		cat | base64 --decode
	else
		printf '%s' $1 | base64 --decode
	fi
}

encode64 () {
	if [[ $# -eq 0 ]]
	then
		cat | base64
	else
		printf '%s' $1 | base64
	fi
}

