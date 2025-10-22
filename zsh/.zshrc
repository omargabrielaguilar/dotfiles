export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="mrtazz"

plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

alias gnstart='sudo wg-quick up wg0'
alias gnstop='sudo wg-quick down wg0'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias shtdw='shutdown now'

export PATH="$PATH:/home/omar/.local/bin"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PHP_CS_FIXER_IGNORE_ENV=1
alias php-cs-fixer-global='php-cs-fixer fix --config=$HOME/.config/php-cs-fixer.php --using-cache=no --allow-risky=yes'

# ls  - exa
alias ls='exa --icons'
alias l='exa --icons -lh'
alias ll='exa --icons -lah'
alias la='exa --icons -A'
alias lm='exa --icons -m'
alias lr='exa --icons -R'
alias lg='exa --icons -l --group-directories-first'
