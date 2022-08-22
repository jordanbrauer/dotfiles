.DEFAULT_GOAL := help
.PHONY: $(MAKECMDGOALS)

help: ## Show this help message
	@printf "\033[33mUsage:\033[0m\n  make [target] [arg=\"val\"...]\n\n\033[33mTargets:\033[0m\n"
	@grep -E '^[-a-zA-Z0-9_\.\/]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[32m%-15s\033[0m %s\n", $$1, $$2}'

sync: ## Sync all symlinks for the configurations
	@stow vim bash config
	@stow --dir=./config/.config/ --target="$$HOME/Library/Application Support/nushell" nushell

install: ## Attempt to install dependencies. Typically only used for new computers
	@# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	@brew update
	@brew install node php yarn nvm jq xsv bat fzf bash bottom glow ripgrep fd stow code-minimap tldr nushell vivid starship
	@brew install --HEAD luajit neovim
	@yarn global add intelephense typescript typescript-language-server awsx
	@# mkdir ~/.vim/{plugged,undodir}
	@touch ~/.gitconfig.neo
	@bat cache --build