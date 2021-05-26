SHELL = /bin/bash
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos linux)
PATH := $(DOTFILES_DIR)/bin:$(PATH)

export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

.PHONY: test

all: $(OS)

macos: sudo core-macos oh-my-zsh packages

linux: core-linux link

core-macos: brew git

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f


sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

oh-my-zsh:
	test -f $(HOME)/.oh-my-zsh/oh-my-zsh.sh ||curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

packages: brew-packages cask-apps node-packages composer-apps mas-apps after

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

git: brew
	brew install git git-extras

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true

composer-apps: brew
	for APP in $$(cat install/Composerfile); do composer global require $$APP; done
	grep -qxF '$(HOME)/.composer/vendor/bin' /etc/paths || echo '$(HOME)/.composer/vendor/bin' | sudo tee -a /etc/paths

mas-apps: brew
	for APP in $$(awk '{ print $$1 }' install/Masfile); do mas install $$APP; done

node-packages:
	npm install -g $(shell cat install/npmfile)

after:
	chmod +x install/after
	install/after

test:
	. $(NVM_DIR)/nvm.sh; bats test


