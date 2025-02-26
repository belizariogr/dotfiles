
export TERM=xterm-256color

# node
export PATH="/opt/homebrew/opt/node@20/bin:/opt/homebrew/bin/npm:$PATH"

# mariadb
export PATH="/opt/homebrew/opt/mariadb@11.4/bin:$PATH"

# postgres
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

#node
export PATH="/opt/homebrew/opt/node@20/bin/node:$PATH"

# bun completions
# [ -s "/Users/belizario/.bun/_bun" ] && source "/Users/belizario/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"