export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="pmcgee"

plugins=(
    git
    vi-mode
    docker
    fzf
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
    laravel
)

source $ZSH/oh-my-zsh.sh

alias gnstart='sudo wg-quick up wg0'
alias gnstop='sudo wg-quick down wg0'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias gtm='function _gtm(){ git add . && git commit -m "$1" && git push origin main; }; _gtm'
alias gts='git status'
alias shtdw='shutdown now'

export PATH="$PATH:/home/omar/.local/bin"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

# Flujo de trabajo laravel -- dev
alias tinker="php artisan tinker"
alias pint="./vendor/bin/pint"
alias pa='php artisan'
alias pamfs='php artisan migrate:fresh --seed'


export PATH=$PATH:$HOME/go/bin
export PATH="$HOME/.cargo/bin:$PATH"

. "/home/omar/.deno/env"

# ls  - exa
alias ls='exa --icons'
alias l='exa --icons -lh'
alias ll='exa --icons -lah'
alias la='exa --icons -A'
alias lm='exa --icons -m'
alias lr='exa --icons -R'
alias lg='exa --icons -l --group-directories-first'

export PATH="$HOME/.composer/vendor/bin:$PATH"

#python
alias so='source .venv/bin/activate'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
