
export TERM=xterm-256color

# Oh-my-zsh Config
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="belizario"
plugins=(
    git
    zsh-autosuggestions
    fast-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

PLATFORM="$(uname -o)-$(uname -m)"
if [ $PLATFORM = 'Darwin-arm64' ]; then
    export PATH="/opt/homebrew/opt/node@20/bin:/opt/homebrew/opt/mariadb@11.4/bin:$PATH"
fi
# bun completions
[ -s "/Users/belizario/.bun/_bun" ] && source "/Users/belizario/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
