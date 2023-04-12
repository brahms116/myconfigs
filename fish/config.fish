set -gx PATH "$PATH:$HOME/dotfiles/scripts"
set -gx PATH "$PATH:$HOME/dev/tools"
set -gx PATH "$PATH:$HOME/usr/local/go/bin"
set -gx PATH "$PATH:$HOME/go/bin"
set -gx PATH "$PATH:$HOME/.bin"
set -gx PATH "$PATH:Library/Python/3.8/"
set -gx PATH "$PATH:Library/Python/3.8/lib/python/site-packages/pipenv/bin/"
set -gx PATH "$PATH:$ANDROID_HOME/emulator"
set -gx PATH "$PATH:$ANDROID_HOME/platform-tools"
set -gx ANDROID_HOME "$HOME/Library/Android/sdk"

set -gx API_ENDPOINT "https://aqo9tu62bl.execute-api.ap-southeast-2.amazonaws.com/PROD"
set -gx ENVIRONMENT "DEV"

set -gx TOOLS_DIR "$HOME/dev/tools"
set -gx ESLINT_D_LOCAL_ESLINT_ONLY 1
set -gx PATH "$PATH:$HOME/.cargo/bin"
set -gx EDITOR nvim
set -gx PATH "/usr/local/opt/mongodb-community@4.4/bin:$PATH"

source ~/.asdf/asdf.fish

if status is-interactive
    # Commands to run in interactive sessions can go here
    alias ls="exa -al --no-permissions"
    alias lsr="exa -al --tree -R --level=2 --no-permissions"
    alias lg=lazygit
    alias cl=clear
    alias vi=nvim
end

