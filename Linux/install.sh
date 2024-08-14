#!/bin/bash

show_help(){
  echo "Usage: $(basename ${BASH_SOURCE[0]}) [OPTIONS]"
  echo 
  echo "these are common install command"
  echo "  --help"
  echo "  --oh-my-posh"
}
# 引数が指定されているかチェック
if [ $# -eq 0 ]; then
    show_help
    return 0
fi

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
}

install_Nerd_fonts(){
    chmod +x $HOME/Linux/nerd-fonts.sh
    source $HOME/Linux/nerd-fonts.sh -i https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DroidSansMono/DroidSansMNerdFontMono-Regular.otf -u
}

validate_dependencies
#install_Nerd_fonts

oh_my_posh(){
   # oh-my-poshのダウンロード
   # 実行ファイルの場所は.local/binで、themeの場所は.poshtemes
  mkdir -p $HOME/.local/bin
  chmod u+rwX $HOME/.local/bin
  mkdir -p $HOME/.poshthemes
  source $HOME/oh-my-posh.sh -d $HOME/.local/bin
  source $HOME/.bashrc
}



# 引数解析
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --help)
            show_help
            ;;
        --oh-my-posh)
            oh_my_posh
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
    shift
done
