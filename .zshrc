
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
    export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/node@20/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/node@20/include"
fi