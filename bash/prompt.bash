# simple, two-line bash prompt
# switches from $ to # when root
PROMPT_CHAR () {
    if [ "$(id -u)" -eq 0 ]
    then
        printf '#';
    else
        printf '$';
    fi;
}
PS1="\n[\u@\h] \w\a\n$(PROMPT_CHAR) "
