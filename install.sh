#!/bin/bash

show_help(){
  echo "Usage: $(basename ${BASH_SOURCE[0]}) [OPTIONS]"
  echo 
  echo "these are common install command"
  echo "  --help"
  echo "  --oh-my-posh"
  echo "  --tmux"
}

initial_install(){
  sudo apt install zip 
  sudo apt install unzip 
}

oh_my_posh(){
  sudo wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/local/bin/oh-my-posh
  sudo chmod +x /usr/local/bin/oh-my-posh

  # テーマのダウンロード
  echo "Downloading themes..."
  mkdir -p ~/.poshthemes
  wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
  unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
  chmod u+rw ~/.poshthemes/*.omp.*
  rm ~/.poshthemes/themes.zip

  mkdir -p ~/.local/share/fonts
  cd ~/.local/share/fonts
  curl -fLo "Hack Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf
  fc-cache -fv

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

oh_my_posh_change_theme(){
  return 0
}

# 引数が指定されているかチェック
if [ $# -eq 0 ]; then
    show_help
    return 0
fi

# 引数解析
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -o|--oh-my-posh)
            oh_my_posh
            ;;
        -oc|--oh-my-posh-change-theme)
            oh_my_posh_change_theme
            ;;
        -t|--tmux)
            ;;
        -i|--initial-install)
            initial_install
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
    shift
done