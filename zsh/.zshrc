export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="mrtazz"

plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias gnstart='sudo wg-quick up wg0'
alias gnstop='sudo wg-quick down wg0'
alias shtdw='shutdown now'

# Load libraries
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

