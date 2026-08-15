#!/usr/bin/zsh

switchSshKey() {
    clear

    local RESET=$'\033[0m'
    local BOLD=$'\033[1m'
    local DIM=$'\033[2m'
    local CYAN=$'\033[36m'
    local GREEN=$'\033[32m'
    local YELLOW=$'\033[33m'
    local MAGENTA=$'\033[35m'
    local RED=$'\033[31m'

    print "${CYAN}${BOLD}╔══════════════════════════════════════════════════╗${RESET}"
    print "${CYAN}${BOLD}║             🔑  SSH KEY SWITCHER                 ║${RESET}"
    print "${CYAN}${BOLD}║    Multi-Profile Manager - Nicolas Codeceira     ║${RESET}"
    print "${CYAN}${BOLD}╚══════════════════════════════════════════════════╝${RESET}\n"

    local options=(
        "Developer - Work Profile"
        "Developer - Personal Profile"
    )

    local i=1
    for opt in "${options[@]}"; do
        print "${BOLD}${i} - ${opt}${RESET}"
        ((i++))
    done

    local choice
    while true; do
        print -n "\n${MAGENTA}${BOLD}👉 Escolha o perfil desejado: ${RESET}"
        read "choice"

        local key_name=""
        local opt=""

        case "$choice" in
            1)
                opt="Developer - Work Profile"
                key_name="id_rsa_work"
                break
                ;;
            2)
                opt="Developer - Personal Profile"
                key_name="id_rsa_personal"
                break
                ;;
            *)
                print "${RED}Opção inválida! Escolha um número válido.${RESET}"
                ;;
        esac
    done

    print "\n${CYAN}🔄 Switching to:${RESET} ${BOLD}$opt${RESET}..."

    ssh-add -D > /dev/null 2>&1
    ssh-add ~/.ssh/"$key_name" > /dev/null 2>&1

    if [ "$key_name" = "id_rsa_work" ]; then
        git config --global user.name "Your Work Name"
        git config --global user.email "your.work@company.com"
        git config --global user.username "work_username"

        export CURRENT_GIT_PROFILE="Work"
        export PROMPT='%F{green}[Work]%f %F{yellow}%~%f %# '

    elif [ "$key_name" = "id_rsa_personal" ]; then
        git config --global user.name "Your Personal Name"
        git config --global user.email "your.personal@gmail.com"
        git config --global user.username "personal_username"

        export CURRENT_GIT_PROFILE="Personal"
        export PROMPT='%F{cyan}[Personal]%f %F{yellow}%~%f %# '
    fi

    print "\n${GREEN}${BOLD}✔ Git user configured as:${RESET}"
    print "  └─ ${YELLOW}$(git config --global user.name)${RESET} ${DIM}<$(git config --global user.email)>${RESET}\n"
    print "${GREEN}${BOLD}Done!${RESET}\n"
}