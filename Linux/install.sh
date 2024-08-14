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
}

install_Nerd_fonts(){
    # 確認したいフォントファイル名
    FONT_FILE="Droid Sans Mono for Powerline Nerd Font Complete.otf"
    FONT_DIR="$HOME/.local/share/fonts"

    # フォントファイルの存在を確認
    if [ -f "$FONT_DIR/$FONT_FILE" ]; then
        echo "no ploblem"
    else
        error "Nerd Font file '$FONT_FILE' does not exist in $FONT_DIR.\n"
    fi
}

oh_my_posh(){
   # oh-my-poshのダウンロード
   # 実行ファイルの場所は.local/binで、themeの場所は.poshtemes
  source $HOME/oh-my-posh.sh -d $HOME/.local/bin
  source $HOME/.bashrc
}

validate_dependencies
install_Nerd_fonts
oh_my_posh
