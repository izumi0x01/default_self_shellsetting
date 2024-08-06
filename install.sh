#!/bin/bash

show_help(){
  echo "Usage: $(basename ${BASH_SOURCE[0]}) [OPTIONS]"
  echo 
  echo "these are common install command"
  echo "  --help"
  echo "  --nerd"
  echo "  --oh-my-posh"
  echo "  --tmux"
}

# 引数が指定されているかチェック
if [ $# -eq 0 ]; then
    show_help
    return 0
fi

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
  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
  fc-cache -fv
  cd ~
}

oh_my_posh(){
  # oh-my-poshのダウンロード
  mkdir -p ~/.local/bin
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
  chmod u+x ~/.local/bin/oh-my-posh

  # 環境変数の追加
  echo 'if [[ "$PATH" != *"$HOME/.local/bin"* ]]; then
      export PATH="$HOME/.local/bin:$PATH"
  fi' >> ~/.bash_profile

  # テーマのダウンロード
  echo "Downloading themes..."
  mkdir -p ~/.poshthemes
  wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
  unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
  chmod u+rw ~/.poshthemes/*.json
  rm ~/.poshthemes/themes.zip


  # .bashrcにOh My Poshの設定を追加
  THEME="paradox" 
  BASHRC_UPDATE="eval \"\$(oh-my-posh init bash --config ~/.poshthemes/${THEME}.omp.json)\""

  if ! grep -Fxq "$BASHRC_UPDATE" ~/.bashrc; then
      echo "Adding Oh My Posh configuration to .bashrc..."
      echo "$BASHRC_UPDATE" >> ~/.bashrc
  else
      echo "Oh My Posh configuration already exists in .bashrc"
  fi

  source ~/.bashrc
}


validate_dependencies

# 引数解析
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --help)
            show_help
            ;;
        --nerd)
            install_Nerd_fonts
            ;;
        --oh-my-posh)
            oh_my_posh
            ;;
        --tmux)
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
    shift
done
