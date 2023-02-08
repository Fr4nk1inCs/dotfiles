# Fr4nk1in's Neovim Configuration

This repository stores my NeoVim config files. Most file are written in lua.

# Setup

> Before setting it up, you should have NeoVim Installed.

## Installation

The default NeoVim config directory is `~/.config/nvim`, so just clone this repo to that directory, which is

```shell
git clone https://github.com/Fr4nk1in-USTC/Nvim-Config.git ~/.config/nvim
```

> If you have trouble connecting Github in mainland China, I recommend you to set up your Github SSH Key and clone it by SSH, which is
>
> ```shell
> git clone git@github.com:Fr4nk1in-USTC/Nvim-Config.git ~/.config/nvim
> ```

## Configuration

Now you should go to the config directory by `cd ~/.config/nvim`.

### Setup [Packer.nvim](https://github.com/wbthomason/packer.nvim)

I use Packer.nvim to manage NeoVim plug-in. So we should set it up first.

1. Download Packer.nvim.
   ```shell
   git clone --depth 1 https://github.com/wbthomason/packer.nvim
   \ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   ```
   > For those who have network issues:
   >
   > ```
   > git clone --depth 1 git@github.com:wbthomason/packer.nvim.git
   > \ ~/.local/share/nvim/site/pack/packer/start/packer.nvim
   > ```
2. Set up all the plug-ins. Run `nvim +PackerSync`
   > If you have network issue, add the following config at the **beginning** of `~/.config/nvim/lua/packages/init.lua`
   >
   > ```lua
   > packer.init({
   >     git = {
   >         default_url_format = "git@github.com:%s"
   >     }
   > })
   > ```
