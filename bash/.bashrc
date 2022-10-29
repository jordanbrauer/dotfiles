if [[ $(arch) == 'arm64' ]]; then
  export SHELL_ARCH="arm64"
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
else
  export SHELL_ARCH="x86"
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

export PATH="$HOME/.composer/vendor/bin:/usr/local/bin/php:$PATH"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export BASH_SILENCE_DEPRECATION_WARNING=1 # silence the shitty zsh warning from MacOS

eval "$(/opt/homebrew/bin/brew shellenv)"
set -o vi

[[ $TERM == 'xterm-kitty' ]] && source <(kitty + complete setup bash)
