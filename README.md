# 🔑 SSH Key Switcher

> Um utilitário **Zsh** leve, rápido e visual para alternar dinamicamente entre múltiplas chaves SSH, perfis do Git e prompts do terminal com apenas um comando.

![Zsh](https://img.shields.io/badge/Shell-Zsh-blue?style=flat-square&logo=gnu-bash)
![Git](https://img.shields.io/badge/Git-Config_Manager-F05032?style=flat-square&logo=git)
![License](https://img.shields.io/badge/Licen%C3%A7a-MIT-green?style=flat-square)

---

## 📌 Funcionalidades

- 🔄 **Troca de perfil em um comando:** Limpa as chaves SSH antigas da memória e adiciona a escolhida em segundos.
- 👤 **Configuração do Git automatizada:** Atualiza `user.name`, `user.email` e `user.username` globalmente por perfil.
- 🎨 **Prompt dinâmico no terminal:** Atualiza o prompt nativo do Zsh (`PROMPT`) e exporta a variável `CURRENT_GIT_PROFILE` para prompts customizados (como o Starship).
- 🎨 **Feedback visual:** Output limpo com cores ANSI e confirmação clara das alterações.

---

## 🚀 Início Rápido

### 1. Pré-requisitos

Certifique-se de que suas chaves SSH já estão geradas e salvas no diretório `~/.ssh/`.
