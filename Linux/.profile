# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

if [[ "$PATH" != *"$HOME/.local/bin"* ]]; then
      export PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.local/share/gem/ruby/$(ruby -e "puts RbConfig::CONFIG[\"ruby_version\"]")/bin:$PATH"