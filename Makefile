DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all: update link init install ## Run make update, link, init, install
	@exec $$SHELL

update: ## Fetch changes for this repo
	git pull origin master

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)
	@echo $$DOTPATH

link: ## Create symlink to home directory
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

clean: ## Remove the dot files and this repo
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)

init: ## Setup minimum environment
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/init/init.sh

install: ## Install applications
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/install/install.sh

test: link init ## Run make link, init
	@exec $$SHELL

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
