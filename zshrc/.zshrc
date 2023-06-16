export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$PATH:/Users/r/flutter/bin"
alias md='mkdir'
alias ll='ls -laF'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
. "$HOME/.cargo/env"
alias h='cd ~'
alias rsrun='cargo run'
alias zshrc='vi ~/.zshrc'
alias vimrc='vi ~/.config/nvim/init.vim'
alias initvim='vi ~/.config/nvim/init.vim'
alias vi='nvim'
alias vim='nvim'
alias view='nvim -R'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# Powerline
function powerline_precmd() {
  PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi
