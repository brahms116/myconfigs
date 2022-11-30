set -gx PATH "$PATH:$HOME/dotfiles/scripts"
set -gx PATH "$PATH:$HOME/dev/tools"
set -gx TOOLS_DIR "$HOME/dev/tools"

set -gx ESLINT_D_LOCAL_ESLINT_ONLY 1

set -gx FZF_DEFAULT_COMMAND 'rg --files --follow --no-ignore-vcs --hidden -g "!{node_modules/*,.git/*}"'

set -gx PATH "$PATH:$HOME/.cargo/bin"

set -gx EDITOR nvim
set -gx PATH "/usr/local/opt/mongodb-community@4.4/bin:$PATH"


if status is-interactive
    # Commands to run in interactive sessions can go here
end