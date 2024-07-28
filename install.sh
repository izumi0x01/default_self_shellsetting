#!/bin/bash

show_help(){
  echo "Usage: $(basename ${BASH_SOURCE[0]}) [OPTIONS]"
  echo 
  echo "these are common install command"
  echo "  --help"
  echo "  --oh-my-posh"
  echo "  --tmux"
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
            ;;
        -t|--tmux)
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
    shift
done