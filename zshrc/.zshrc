# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$PATH:/Users/r/flutter/bin"
export PATH="$PATH":"$HOME/go/bin"
alias md='mkdir'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport'
. "$HOME/.cargo/env"
alias h='cd ~'
alias rsrun='cargo run'
alias zshrc='vi ~/.zshrc'
alias vimrc='vi ~/.config/nvim/init.lua'
alias initvim='vi ~/.config/nvim/init.lua'
alias wrc='vi ~/.config/wezterm/wezterm.lua'
alias vi='nvim'
# alias vim='nvim'
alias view='nvim -R'
alias s='source ~/.zshrc'
alias g='cd ~/Documents/GitHub'
alias q='exit'
alias gita='git add .'
alias gitc='git commit -m'
alias gitps='git push'
alias gitpl='git pull'
alias ll='ls -alh'
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
alias confa="rm -rf ~/.config/nvim && cp -r ~/.config/nvim_mydotfiles ~/.config/nvim"
alias confb="rm -rf ~/.config/nvim && cd ~/Documents/Github/dotFiles/nvim && sh refresh.sh"

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
export PATH=~/Documents/GitHub/mac_shell/bin:$PATH
# auto complete
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# export OPENAI_API_KEY='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'
source "$HOME/.openai_key.zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/unzip/bin:$PATH"
export PATH="~/tools:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
