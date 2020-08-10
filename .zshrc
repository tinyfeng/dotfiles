#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# Source Prezto.
profile_script_start() {
  #gdate "+%T.%3N start $1"
}
profile_script_end() {
  #gdate "+%T.%3N end $1"
}
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  profile_script_start "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi
# Customize to your needs...
for config_file ($HOME/.yadr/zsh/*.zsh) profile_script_start "$config_file" && source $config_file
PATH=$HOME/bin:$PATH
export PATH
profile_script_start "completion path"
fpath=(~/.zsh/completion $fpath)
profile_script_start "completion init"
autoload -Uz compinit && compinit -i # is it necessary here?
alias vi="nvim"
alias vim="nvim"
export EDITOR='nvim'
alias c="clear"
export XDG_DATA_HOME="$HOME/.config/nvim"
alias oc="/usr/local/octave/3.8.0/bin/octave-3.8.0 ; exit;"
alias cr="clear"
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export GOPROXY=https://goproxy.io
bindkey '^F' autosuggest-execute
alias tiny="cd ~/tiny"
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PATH="$PATH:/Users/lankr/flutter/bin"
export PATH="$PATH:/Users/lankr/elasticsearch-2.3.0/bin"
export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;
source ~/.bashrc
export PATH="$PATH:/usr/local/mysql/bin"
alias t="tmux new -A -s"
