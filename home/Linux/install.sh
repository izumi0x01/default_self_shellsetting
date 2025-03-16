#!/bin/bash

info() {
    printf "$1\n"
}

warn() {
    printf "⚠️  \e[33m$1\e[0m\n"
}

error() {
    printf "\e[31m$1\e[0m\n"
    exit 1
}


validate_dependency() {
    if ! command -v $1 >/dev/null; then
        error "$1 is required to install . Please install $1 and try again.\n"
    fi
}

validate_dependencies() {
    validate_dependency wget
    validate_dependency curl
    validate_dependency zip
    validate_dependency unzip
    validate_dependency realpath
    validate_dependency dirname
    validate_dependency fontconfig
    validate_dependency ruby
    validate_dependency gem
    validate_dependency ruby-dev
}

install_Nerd_fonts(){
    chmod +x $HOME/Linux/nerd-fonts.sh
    source $HOME/Linux/nerd-fonts.sh -i https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/DroidSansMNerdFontMono-Regular.otf -u
}

oh_my_posh(){
   # oh-my-poshのダウンロード
   # 実行ファイルの場所は.local/binで、themeの場所は.poshtemes
  source $HOME/oh-my-posh.sh -d $HOME/.local/bin
  source $HOME/.bashrc
}

colorls(){
    gem install colorls --user-install
}

validate_dependencies
install_Nerd_fonts
oh_my_posh
colorls
