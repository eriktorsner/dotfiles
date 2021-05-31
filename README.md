# .files

These are my dotfiles. Take anything you want, but at your own risk.

It mainly targets macOS systems


## Installation

On a sparkling fresh installation of macOS. First sign in to your Apple ID so that mas app manager can install App Store Apps. Then at the command prompt:

```bash
sudo softwareupdate -i -a
xcode-select --install
```

Since we're lazy, add passwordless sudo

```bash
export VISUAL=nano
sudo dscl . -append /groups/wheel GroupMembership <username>
sudo visudo /etc/sudoers.d/wheel
```

add the line 

```bash
%wheel    ALL=(ALL)   NOPASSWD: ALL
```

The Xcode Command Line Tools includes `git` and `make` (not available on stock macOS).

Clone manually into the desired location:

```bash
mkdir ~/src
git clone https://github.com/eriktorsner/dotfiles.git ~/src/dotfiles
```

Use the [Makefile](./Makefile) to install all software. This takes a while...

```bash
cd ~/src/dotfiles
make packages
```

## Set up Bitwarden cli

To get the dotfiles including secrets like ssh keys we need to set up bitwarden and get a BW_SESSION key into the env

```bash
bw login
export BW_SESSION=`bw unlock --raw`
```

## Move all the dotfiles into place

This includes secrets from Bitwarden

```bash
bin/dotfiles restore
```

After this step, it should be possible to ssh into remote servers, use the AWS cli etc.

## Restore data from backups

If we're at home or can access the local backup via ssh we can get the backup from the rdiff-backup server. If we can't access it we may want to restore from AWS

```bash
TODO: restore instructions for rdiff
```

```bash
TODO: restore instructions for aws
```


## Post-Installation

- `dotfiles dock` (set [Dock items](./macos/dock.sh))
- `dotfiles macos` (set [macOS defaults](./macos/defaults.sh))

## The `dotfiles` command

```bash
$ dotfiles help
Usage: dotfiles <command>

Commands:
    clean            Clean up caches (brew, npm, gem, rvm)
    dock             Apply macOS Dock settings
    edit             Open dotfiles in IDE (code) and Git GUI (stree)
    help             This help message
    macos            Apply macOS system defaults
    sync             Copy dotfiles and secrets defined in ./sync to this repo and BitWarden. Remember to commit and push to GH
    restore          Copy dotfiles and secrets from this repo and BitWarden back to $HOME
    test             Run tests
    update           Update packages and pkg managers (OS, brew, npm, gem)
```

## Customize

You can put your custom settings, such as Git credentials in the `system/.custom` file which will be sourced from
`.bash_profile` automatically. This file is in `.gitignore`.


## Additional Resources

- [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
- [Homebrew](https://brew.sh)
- [Homebrew Cask](https://github.com/Homebrew/homebrew-cask)
- [Bash prompt](https://wiki.archlinux.org/index.php/Color_Bash_Prompt)
- [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)

## Credits

Many thanks to the [dotfiles community](https://dotfiles.github.io).
