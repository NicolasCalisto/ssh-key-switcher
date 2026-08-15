#!/usr/bin/zsh

switchSshKey() {
    clear

    # Cores e Estilos ANSI no Zsh
    local RESET=$'\033[0m'
    local BOLD=$'\033[1m'
    local DIM=$'\033[2m'
    local CYAN=$'\033[36m'
    local GREEN=$'\033[32m'
    local YELLOW=$'\033[33m'
    local MAGENTA=$'\033[35m'
    local RED=$'\033[31m'

    # Banner de Apresentação
    print "${CYAN}${BOLD}╔══════════════════════════════════════════════════╗${RESET}"
    print "${CYAN}${BOLD}║             🔑  SSH KEY SWITCHER                 ║${RESET}"
    print "${CYAN}${BOLD}║             Multi-Profile Manager                ║${RESET}"
    print "${CYAN}${BOLD}╚══════════════════════════════════════════════════╝${RESET}\n"

    # ==============================================================================
    # 📌 PASSO 1: Mapeamento dos Perfis
    # Para adicionar um novo perfil, inclua o nome que deseja exibir na lista abaixo.
    # Exemplo: "Seu Nome - Empresa"
    # ==============================================================================
    local options=(
        "Developer - Work Profile"
        "Developer - Personal Profile"
    )

    # Exibe as opções em formato de lista vertical (ex: 1 - Work, 2 - Personal)
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

        # ==========================================================================
        # 📌 PASSO 2: Mapeamento das Opções para as Chaves SSH
        # Associe o número digitado ao arquivo de chave contido em ~/.ssh/
        #
        # Exemplo: Se sua chave privada é ~/.ssh/id_rsa_work, o key_name será "id_rsa_work".
        # ==========================================================================
        case "$choice" in
            1)
                opt="Developer - Work Profile"
                key_name="id_rsa_work" # Altere para o nome do arquivo da chave SSH de trabalho
                break
                ;;
            2)
                opt="Developer - Personal Profile"
                key_name="id_rsa_personal" # Altere para o nome do arquivo da chave SSH pessoal
                break
                ;;
            # Para adicionar um 3º perfil:
            # 3)
            #     opt="Developer - Side Project"
            #     key_name="id_rsa_project"
            #     break
            #     ;;
            *)
                print "${RED}Opção inválida! Escolha um número válido da lista.${RESET}"
                ;;
        esac
    done

    print "\n${CYAN}🔄 Switching to:${RESET} ${BOLD}$opt${RESET}..."

    # Limpa as chaves ativas na memória e adiciona a chave escolhida
    ssh-add -D > /dev/null 2>&1
    ssh-add ~/.ssh/"$key_name" > /dev/null 2>&1

    # ==============================================================================
    # 📌 PASSO 3: Configuração do Git e Variáveis de Ambiente por Perfil
    # Configure os dados globais do Git e as variáveis visuais para cada key_name.
    # ==============================================================================
    if [ "$key_name" = "id_rsa_work" ]; then
        # Configurações do Git para Trabalho
        git config --global user.name "Your Work Name"
        git config --global user.email "your.work@company.com"
        git config --global user.username "work_username"

        # Variável consumida pelo Starship (se utilizado)
        export CURRENT_GIT_PROFILE="Work"

        # Prompt nativo do Zsh (%F{green} altera a cor, %~ mostra o diretório)
        export PROMPT='%F{green}[Work]%f %F{yellow}%~%f %# '

    elif [ "$key_name" = "id_rsa_personal" ]; then
        # Configurações do Git Pessoal
        git config --global user.name "Your Personal Name"
        git config --global user.email "your.personal@gmail.com"
        git config --global user.username "personal_username"

        # Variável consumida pelo Starship (se utilizado)
        export CURRENT_GIT_PROFILE="Personal"

        # Prompt nativo do Zsh
        export PROMPT='%F{cyan}[Personal]%f %F{yellow}%~%f %# '

    # Para adicionar um novo bloco:
    # elif [ "$key_name" = "id_rsa_project" ]; then
    #     git config --global user.name "Your Name"
    #     git config --global user.email "email@example.com"
    #     git config --global user.username "username"
    #     export CURRENT_GIT_PROFILE="Project"
    #     export PROMPT='%F{magenta}[Project]%f %F{yellow}%~%f %# '
    fi

    # Confirmação visual no terminal
    print "\n${GREEN}${BOLD}✔ Git user configured as:${RESET}"
    print "  └─ ${YELLOW}$(git config --global user.name)${RESET} ${DIM}<$(git config --global user.email)>${RESET}\n"
    print "${GREEN}${BOLD}Done!${RESET}\n"
}

# no arquivo .zshrc, adicione a linha abaixo para que o script seja carregado no terminal:
# Carrega a função do arquivo externo // caminho absoluto do arquivo switch.sh
#### source /Users/nicolascodeceira/switch.sh
# Cria o alias para a função
#### alias switch='switchSshKey'