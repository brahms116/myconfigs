# Development setup

## Required software

### Terminal Emulator

- [Alacritty](https://linux.how2shout.com/how-to-install-alacritty-terminal-on-ubuntu-22-04-lts/)
- [Iterm2](https://iterm2.com)

### Terminal Related

- Git
- [Fish](https://fishshell.com/)
- [Tmux](https://tmuxcheatsheet.com/how-to-install-tmux/)
- [LazyGit](https://github.com/jesseduffield/lazygit?tab=readme-ov-file#installation)

### Editor related

- [Neovim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [Packer.nvim](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [Rg](https://github.com/neovim/neovim/blob/master/INSTALL.md)
- [Fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#installation)

### Language tooling and LSPs

- [Clangd](https://clangd.llvm.org/installation.html)

Todo.

## Setting up softlinks

```fish
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/fish ~/.config/fish
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/alacritty.toml ~/.alacritty.toml
```

## Future plans
- Move off neovim back into vscode
