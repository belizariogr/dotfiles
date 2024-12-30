
export TERM=xterm-256color

PLATFORM="$(uname -o)-$(uname -m)"
if [ $PLATFORM = 'Darwin-arm64' ]; then
    export PATH="/opt/homebrew/opt/node@20/bin:/opt/homebrew/opt/mariadb@11.4/bin:$PATH"
fi