
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


# node
export PATH="/opt/homebrew/opt/node@20/bin:/opt/homebrew/bin/npm:$PATH"

# mariadb
export PATH="/opt/homebrew/opt/mariadb@11.4/bin:$PATH"

# postgres
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

#node
export PATH="/opt/homebrew/opt/node@20/bin/node:$PATH"

#bin
export PATH="$HOME/.bin:$PATH"

# bun completions
[ -s "/Users/belizario/.bun/_bun" ] && source "/Users/belizario/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# flutter
export PATH=$HOME/fvm/default/bin:$PATH


## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/belizario/.dart-cli-completion/zsh-config.zsh ]] && . /Users/belizario/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# LLVM
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export VCPKG_ROOT="$HOME/.bin/vcpkg"
