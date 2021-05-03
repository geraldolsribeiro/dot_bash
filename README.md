# Configuração do bash

## Instalação

```bash
git clone ssh://git@intmain.io:8322/geraldoim/dot_bash.git $HOME/.bash
ln -s $HOME/.bash/bashrc $HOME/.bashrc
ln -s $HOME/.bash/bash_profile $HOME/.bash_profile
```

## Padronização dos diretórios em inglês

O script `user-dir` configura os diretórios para inglês preservando o idioma do resto.

## Nota

Após a atualização para o Debian 10 uma mensagem de erro do ruby é exibida toda
vez que executa o script de inicialização. Uma maneira de contornar este
problema é usar o ruby na versão 3.0.6 (downgrade).

```bash
gem update --system 3.0.6
```
