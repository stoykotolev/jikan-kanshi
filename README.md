<div align="center">

# Jikan Kanshi

##### Track your programming languages usage.

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

<img alt="Harpoon Man" height="280" src="/assets/harpoon-icon.png" />
</div>

## TOC

- [Goal] (#Goal)
- [Installation] (#Installation)
- [Getting started] (#Getting-started)
- [Contribution] (#Contribution)
- [Todo] (#Todo)

## Goal

Have you ever wondered in what languages you have spent the most time in and what your programming life looks like?
With **Jikan Kanshi** you can track all of that and even someday, maybe have a beautiful UI, that will show you in which ecosystem you spend your time the most.  
It detects when your neovim instance is in and out of focus and makes sure that you are actually writing code and not just stat padding!

## Installation

- neovim 0.8.0+ required
- install using your favorite plugin manager (i am using `lazy`)
- install using [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
}
```

## Getting started

The plugin doesn't require much in terms of setting up and configuration. Once you have installed it, it will start tracking all of your data.
The file is stored in the `~/.local/share/nvim/jikan-kanshi` folder if you'd like to get a copy of it and do something with it.

## Contribution

This is an open source project and I am always open for interesting and fun suggestions. You are free to open an issue and we can discuss your feature idea in there.

## Todo

- [ ] Create a UI that visualizes the data collected for all different programming languages.
- [ ] Syncing. Currently, it is all local and if you move to another machine, unless you copy the plugin file with you, the data will be fresh. There may be a way to figure out how to sync and store that and have it available.
