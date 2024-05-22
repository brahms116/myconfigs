set -gx PATH "$PATH:$HOME/dotfiles/scripts"
set -gx PATH "$PATH:$HOME/dev/tools"
set -gx PATH "$PATH:/usr/local/go/bin"
set -gx PATH "$PATH:$HOME/go/bin"
set -gx PATH "$PATH:$HOME/.bin"
set -gx PATH "$PATH:Library/Python/3.8/"
set -gx PATH "$PATH:Library/Python/3.8/lib/python/site-packages/pipenv/bin/"
set -gx PATH "$PATH:$ANDROID_HOME/emulator"
set -gx PATH "$PATH:$ANDROID_HOME/platform-tools"
set -gx ANDROID_HOME "$HOME/Library/Android/sdk"

set -gx fish_key_bindings fish_vi_key_bindings

bind --mode insert jj 'set fish_bind_mode default; commandline -f backward-char repaint-mode;'

set -gx FZF_DEFAULT_COMMAND 'rg --no-ignore --files --follow --hidden -g "!{**/node_modules/**,.git/*,**/dist/**,**/target/**}"'

set -gx API_ENDPOINT "https://aqo9tu62bl.execute-api.ap-southeast-2.amazonaws.com/PROD"
set -gx ENVIRONMENT "DEV"

set -gx TOOLS_DIR "$HOME/dev/tools"
set -gx ESLINT_D_LOCAL_ESLINT_ONLY 1
set -gx PATH "$PATH:$HOME/.cargo/bin"
set -gx EDITOR nvim
set -gx PATH "/usr/local/opt/mongodb-community@4.4/bin:$PATH"

if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
end

if test -e /opt/homebrew/opt/asdf/libexec/asdf.fish
  source /opt/homebrew/opt/asdf/libexec/asdf.fish
end

if test -e ~/.secrets.fish
  source ~/.secrets.fish
end

if test -e ~/.path.fish
  source ~/.path.fish
end

if test -e ~/.alias.fish
  source ~/.alias.fish
end

if test -e ~/.setup.fish
  source ~/.setup.fish
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    alias lg=lazygit
    alias cl=clear
    alias vi=nvim
    alias mx='tmuxinator'
    alias x='tmux'
    alias repl='cd ~/dev/scripts-hs && stack repl ./main.hs'
    alias k='kubectl'
    alias dockerLogin='echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
end

# opam configuration
source /Users/davidkwong/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

set PATH $PATH /Users/davidkwong/.local/bin
