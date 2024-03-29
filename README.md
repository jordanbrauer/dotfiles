# .dotfiles

Here lay a currated list of the tools I use or have used at one point in time or
another. Consider this my _virtual toolbelt_, full of the well worn & maintained
trappings of a hacker. Perhaps they will be as useful to you, dear reader, as
they are to me.

_Happy hacking!_

## Setting Up

These instructions are for new machines.

1. Clone this repository into the home directory.
    ```shell
    git clone git@github.com:jordanbrauer/dotfiles.git ~/.dotfiles
    ```
2. Install all necessary dependencies.
    ```shell
    # probably a few that aren't in this install script lol
    make install
    ```
3. Sync the configurations
    ```
    make sync
    ```

> **Warning**
> These configurations make use of [Nerd Font](https://www.nerdfonts.com/cheat-sheet)
> gylphs. Make sure to use a font that supports dev icons.

## Syncing New Configurations

If a new package is being added, simply create the directory & files, then edit
the `Makefile` `sync` target to include it. Alterantively you can (un)stow the
new package individually to test it before altering the `Makefile`.

If adding a new file to an existing package, no extra work is required.

Once all of the new new files are in place, simply run

```shell
make sync
```

## Terminal ([kitty](https://sw.kovidgoyal.net/kitty/))

It's fast, sleak, fully configurable, scriptable.. what's not to love? Plus,
_cats_.

### [starship](https://starship.rs/)

Configuring a beautiful prompt has never been easier...

### [pfetch](https://github.com/dylanaraps/pfetch)

Minimalistic system information. An alternative to fetch, neofetch, etc.

### [vivid](https://github.com/sharkdp/vivid)

Properly configure colours for `ls` output in a consistent manner.

## Shell ([Nushell](https://www.nushell.sh/))

Bash was awesome for many years, however I am now a Nushell convert.

## Editor ([Neovim](https://neovim.io/))

A few dependencies for Neovim & plugins.

- `luajit`
- `ripgrep`
- `code-minimap`

Other resources

- https://github.com/nanotee/nvim-lua-guide

## Package Managers

How I install my tools.

### [Composer](https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md)

PHP package manager. Not much else to say .. it's great for projects and global
executables.

### [Homebrew](https://brew.sh/)

My choice of package manager as a Mac OS user.

## Other Tools

A bunch of other random tools I've accrued over time on my belt. Some are fun,
and others are essential.

### [bat](https://github.com/sharkdp/bat)

Better `cat(1)`.

### [bottom](https://github.com/ClementTsang/bottom)

`top` and `htop` are fine, but a bit too boring for my liking.

### [choosealicense](https://pypi.org/project/choosealicense-cli/)

I don't like creating repositories with GitHub containing default files. In this
case, a `LICENSE`. It's also annoying to visit [choosealicence.com](https://choosealicense.com/)
everytime.

### [fnm](https://github.com/Schniz/fnm)

`nvm` is too slow, bloated, and confusing. Only really use this for my day-job,
as I don't write much JavaScript otherwise.

### [fzf](https://github.com/junegunn/fzf)

Great for scripting and filtering large amounts of data. Great when you need it
for one-offs, but is sort of replaced by `gum` when you want to write a helper
script that sticks around.

I used to use this with Neovim, but have since switched to Telescope &
`ripgrep`.

### [glow](https://github.com/charmbracelet/glow)

A terminal-based markdown reader. It's absolutely fantastic for reading
`README`s and your own markdown documents.

### [gum](https://github.com/charmbracelet/gum)

A series of elegant helpers to write beautiful shell scripts with. This is a
huge time saver.

### [jq](https://stedolan.github.io/jq/)

A command-line JSON parser, among other things.

An amazing tool, and absolutely good to have, however as a Nushell user, this
has lost a lot of value over time.

### [op](https://1password.com/downloads/command-line/)

The 1Password CLI. Great for scripting all kinds of authentication.

### [psysh](https://psysh.org/)

An improved PHP REPL.

Also used with Neovim & [Codi](https://github.com/metakirby5/codi.vim) as an
interactive scratchpad. A mix between a REPL & editor.

### [slides](https://github.com/maaslalani/slides)

A markdwn, terminal-based slide deck. Originally I used [`lookatme`](https://pypi.org/project/lookatme/),
but if I am honest, I don't really like installing or using Python (pip)
packages and as such, gladly moved to `slides`.

### [stow](https://www.gnu.org/software/stow/)

Symlink farm manager. This tool is how I sync all the configurations from this
repository into my system. Without this, setting up a new machine would always
be some kind of pain in the ass. Now, I simply clone this repsitory and run the
appropriate `stow` command (kept in the `Makefile`).

### [tldr](https://github.com/tldr-pages/tldr)

A more succicnt `man`.

### [todo.sh](https://github.com/todotxt/todo.txt-cli)

A scriptable, terminal-based todo list.

### [tt](https://github.com/lemnos/tt)

A scriptable, terminal-based typing test.

### [xsv](https://github.com/BurntSushi/xsv)

`jq` but for CSVs. Pretty great, but Nushell kind of replaces the need for it.
