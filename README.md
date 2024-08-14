# Development setup

## Required software

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

TODO.

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
