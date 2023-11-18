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
alias ll='eza -alh'
alias ls='eza'
alias cat='bat'
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
alias confa="rm -rf ~/.config/nvim && cp -r ~/.config/nvim_mydotfiles ~/.config/nvim"
alias confb="rm -rf ~/.config/nvim && cd ~/Documents/Github/dotFiles/nvim && sh refresh.sh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
export PATH=~/Documents/GitHub/mac_shell/bin:$PATH
# auto complete
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source "$HOME/.openai_key.zsh"
# export PS1='▸'
# export PS1='%F{green}▸%f '
# export PS1='%F{#FF0000}▸%f %F{#00FF00}▸%f %F{#FFFF00}▸%f %F{#FF00FF}▸%f '
# export PS1='%F{#FF0000}%K{#FFFFFF}▸%f%k %F{#00FF00}▸%f %F{#FFFF00}▸%f %F{#FF00FF}▸%f '
export PS1='%F{#FF0000}⫸%f %F{#00FF00}⫸%f %F{#FFFF00}⫸%f %F{#FF00FF}⫸%f '
export PS1='%K{#FF0000} %k%F{#FF0000}%K{#FF00FF}%f %k%F{#FF00FF}%K{#0000FF}%f %k%F{#0000FF}%K{#00FF00}%f %k%F{#00FF00}%f '
# export PS1='%K{#020} %k%F{#020}%K{#050}%f %k%F{#050}%K{#090}%f %k%F{#090}%K{#0c0}%f %k%F{#0c0}%f '
# export PS1='%K{#102} %k%F{#102}%K{#205}%f %k%F{#205}%K{#308}%f %k%F{#308}%K{#40b}%f %k%F{#40b}%f '
# export PS1='%K{#102} %k%F{#102}%K{#205}%f %k%F{#205}%K{#308}%f %k%F{#308}%K{#40b}%f %F{#AA88FF}%1d%f %k%F{#40b}%f %F{#0f6}'
export PS1='%K{#102} %k%F{#102}%K{#205}%f %k%F{#205}%K{#308}%f %k%F{#308}%K{#40b}%f %F{#AA88FF}%1d%f %k%F{#40b}%f '

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/unzip/bin:$PATH"
export PATH="~/tools:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
