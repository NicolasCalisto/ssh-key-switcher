# 🔑 SSH Key Switcher

> Um utilitário **Zsh** leve, rápido e visual para alternar dinamicamente entre múltiplas chaves SSH, perfis do Git e prompts do terminal com apenas um comando.

![Zsh](https://img.shields.io/badge/Shell-Zsh-blue?style=flat-square&logo=gnu-)
![Git](https://img.shields.io/badge/Git-Config_Manager-F05032?style=flat-square&logo=git)
![License](https://img.shields.io/badge/Licen%C3%A7a-MIT-green?style=flat-square)

---

## 📌 Funcionalidades

- 🔄 **Troca de perfil instantânea:** Limpa as chaves SSH antigas da memória e adiciona a escolhida.
- 👤 **Configuração do Git automatizada:** Atualiza `user.name`, `user.email` e `user.username` globalmente por perfil.
- 🎨 **Prompt dinâmico:** Atualiza o prompt nativo do Zsh (`PROMPT`) e exporta a variável `CURRENT_GIT_PROFILE` (compatível com Starship).
- 🎨 **Feedback visual:** Interface interativa com cores ANSI e confirmação clara no terminal.

---

## 🚀 Instalação e Uso

### 1. Pré-requisitos
Certifique-se de que suas chaves SSH já estão geradas e salvas na pasta `~/.ssh/`.

### 2. Baixar o Script
Clone este repositório para o seu ambiente local:

```zsh
git clone [https://github.com/NicolasCalisto/ssh-key-switcher.git](https://github.com/NicolasCalisto/ssh-key-switcher.git) ~/.config/ssh-key-switcher
```

### 3. Configurar no .zshrc
Adicione o script e um alias ao seu arquivo ~/.zshrc:

#### - Carrega o script
        source ~/.config/ssh-key-switcher/switch-ssh.sh

#### - Cria o atalho no terminal
        alias switch="switchSshKey"

### 4. Executar
Rode o alias configurado no terminal:

## SWITCH 🛠 Passo a Passo: Como Customizar os Perfis
Toda a personalização de perfis é feita editando o arquivo switch-ssh.sh.

### Passo 1: Definir os nomes no menu
Edite o array options para listar os nomes que deseja exibir:

local options=(
    "Trabalho - Empresa"
    "Pessoal - GitHub"
)
### Passo 2: Mapear a escolha para o arquivo de chave SSH
No bloco case "$choice" in, associe o número escolhido ao nome exato da chave contida em ~/.ssh/:


```
case "$choice" in
    1)
        opt="Trabalho - Empresa"
        key_name="id_rsa_work" # Nome do arquivo em ~/.ssh/
        break
        ;;
    2)
        opt="Pessoal - GitHub"
        key_name="id_rsa_personal" # Nome do arquivo em ~/.ssh/
        break
        ;;
esac
```

### Passo 3: Configurar credenciais do Git e Variáveis
No bloco if/elif, defina os dados do Git e o visual do prompt para cada key_name:

```
if [ "$key_name" = "id_rsa_work" ]; then
    git config --global user.name "Seu Nome Trabalho"
    git config --global user.email "trabalho@empresa.com"
    git config --global user.username "user_work"

    export CURRENT_GIT_PROFILE="Work"
    export PROMPT='%F{green}[Work]%f %F{yellow}%~%f %# '

elif [ "$key_name" = "id_rsa_personal" ]; then
    git config --global user.name "Seu Nome Pessoal"
    git config --global user.email "pessoal@gmail.com"
    git config --global user.username "user_personal"

    export CURRENT_GIT_PROFILE="Personal"
    export PROMPT='%F{cyan}[Personal]%f %F{yellow}%~%f %# '
fi
```

## ➕ Como Adicionar um Novo Perfil (Ex: Projeto Paralelo)
Para adicionar um 3º perfil ao script, siga estes 3 passos simples:
Adicionar no menu:

```
local options=(
    "Trabalho - Empresa"
    "Pessoal - GitHub"
    "Side Project - Freela" # Novo perfil
)
```

Adicionar no case:

```
3)
    opt="Side Project - Freela"
    key_name="id_rsa_freela"
    break
    ;;
```

Adicionar no if/elif:

```
elif [ "$key_name" = "id_rsa_freela" ]; then
    git config --global user.name "Seu Nome"
    git config --global user.email "freela@email.com"
    git config --global user.username "freela_user"

    export CURRENT_GIT_PROFILE="Freela"
    export PROMPT='%F{magenta}[Freela]%f %F{yellow}%~%f %# '
fi
```