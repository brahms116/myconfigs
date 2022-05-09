fish_add_path "$HOME/config/scripts"
fish_add_path "$HOME/dev/tools"
fish_add_path "$HOME/go/bin"
fish_add_path "$HOME/.bin"
fish_add_path "$ANDROID_HOME/emulator"
fish_add_path "$ANDROID_HOME/platform-tools"
fish_add_path "$HOME/.cargo/bin"
fish_add_path "$HOME/.dotnet/tools"

set -gx ANDROID_HOME "$HOME/Library/Android/sdk"

set -gx fish_key_bindings fish_vi_key_bindings

bind --mode insert jj 'set fish_bind_mode default; commandline -f backward-char repaint-mode;'

set -gx FZF_DEFAULT_COMMAND 'rg --no-ignore --files --follow --hidden -g "!{**/node_modules/**,.git/*,**/dist/**,**/target/**}"'

set -gx TOOLS_DIR "$HOME/dev/tools"
set -gx EDITOR nvim

if test -e ~/.asdf/asdf.fish
  source ~/.asdf/asdf.fish
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
    alias k='kubectl'
    alias dockerLogin='echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin'
		# alias vt='nvim -c "terminal" -c "startinsert"'
		function vt
				nvim -c "terminal fish -i -c \"$argv; exec fish\"" -c "startinsert"
		end
end

# Defined in /opt/homebrew/Cellar/fish/4.0.2/share/fish/functions/fish_prompt.fish @ line 4
function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
    set -l normal (set_color normal)
    set -q fish_color_status
    or set -g fish_color_status red

    # Color the prompt differently when we're root
    set -l color_cwd $fish_color_cwd
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        end
        set suffix '#'
    end

    # Write pipestatus
    # If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
    set -l bold_flag --bold
    set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
    if test $__fish_prompt_status_generation = $status_generation
        set bold_flag
    end
    set __fish_prompt_status_generation $status_generation
    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color $bold_flag $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

    echo -s (set_color $color_cwd) (prompt_pwd) $normal (fish_vcs_prompt) $normal " "$prompt_status " " \n
end

function fish_mode_prompt
end
