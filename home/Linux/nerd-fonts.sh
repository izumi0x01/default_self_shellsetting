
#機能
#- mac, linuxそれぞれの環境でインストール
#- userかsysのどちらにも入れられる
#- 好きなフォントをダウンロード可能
#- cleanはいる
#- dryrun, quiet, otf, いらない。

#!/bin/bash

dry=false
mode="install"
installpath="user"
URL=""

info() {
    printf "$1\n"
}

error() {
    printf "\e[31m$1\e[0m\n"
    exit 1
}

usage(){
  cat << EOF

EOF
}


while getopts ":hdri:su" option; do
  case $option in
    h) usage; exit 0;;
    d) dry=true;;
    r) mode="remove";;
    i) mode="install"
       URL=${OPTARG};;
    s) installpath="system";;
    u) installpath="user";;
    *)
      echo "Unknown option -${OPTARG}" >&2
      usage >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

# Get target root directory
if [[ $(uname) == 'Darwin' ]]; then
  # MacOS
  sys_share_dir="/Library"
  usr_share_dir="$HOME/Library"
  font_subdir="Fonts"
else
  # Linux
  sys_share_dir="/usr/local/share"
  usr_share_dir="$HOME/.local/share"
  font_subdir="fonts"
fi
if [ -n "${XDG_DATA_HOME}" ]; then
  usr_share_dir="${XDG_DATA_HOME}"
fi
sys_font_dir="${sys_share_dir}/${font_subdir}/NerdFonts"
usr_font_dir="${usr_share_dir}/${font_subdir}/NerdFonts"

if [[ "system" == "$installpath" ]]; then
  font_dir="${sys_font_dir}"
else
  font_dir="${usr_font_dir}"
fi

#execute command
case $mode in 
  install) 
    mkdir -pv "$font_dir"
    cd $font_dir
    http_response=$(curl -sfL $URL -O -w "%{http_code}")
    if [ $http_response != "200" ]; then
      error "Unable to download executable at ${URL}\nPlease validate your curl, connection and/or proxy settings"
      exit 1
    fi
    chmod +x $font_dir/*
    info "🚀 Installation complete."
    cd ~
    ;;
  remove)
    if [[ "true" == "$dry" ]]; then
      echo "Dry run. Would issue these commands:"
      echo rm -rfv "$sys_font_dir" "$usr_font_dir"
    else
      rm -rfv "$sys_font_dir" "$usr_font_dir"
    fi
    font_dir="$sys_font_dir $usr_font_dir"
    info "🚀 remove complete."
    ;;
esac

# Reset font cache on Linux
if [[ -n $(command -v fc-cache) ]]; then
  if [[ "true" == "$dry" ]]; then
    echo fc-cache -vf "$font_dir"
  else
    fc-cache -vf "$font_dir"
  fi
  case $? in
    [0-1])
      # Catch fc-cache returning 1 on a success
      exit 0
      ;;
    *)
      exit $?
      ;;
  esac
else
  error "fc-cache not found. You may need to run this command manually."
  exit 1
fi