# Licensed under the Apache License, Version 2.0 (the "License"); you may not
# use this file except in compliance with the License. You may obtain a copy
# of the License at:
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING, SOFTWARE
# DISTRIBUTED UNDER THE LICENSE IS DISTRIBUTED ON AN "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED.
# SEE THE LICENSE FOR THE SPECIFIC LANGUAGE GOVERNING PERMISSIONS AND
# LIMITATIONS UNDER THE LICENSE.

# -----------------------------------------------------------------------------
# Makefile
#
# setup: Prepare Development and Publication environments
# rebase: Rebase local machine environment with upstream repo
# merge: Rebase local machine environment with template repo
# devenv: Prepare development environemnt
# pubenv: Prepare publication environemnt
# publish: Generate HTML and PDF versions of content
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Special targets
# -----------------------------------------------------------------------------

.PHONY: help clean publish
.DEFAULT_GOAL: help

# -----------------------------------------------------------------------------
# Variables
# -----------------------------------------------------------------------------

# Repo Instance Specific
REPO_NAME ?= toip-spec-up
UPSTREAM_REPO ?= https://github.com/trustoverip/spec-up.git
DEV_SITE_PORT ?= 7600
SITE_DIR ?= spec_site/toip

# Template Repo Defaults
CONTAINER_NAME ?= specup-dev-cnr
TEMPLATE_REPO ?= https://github.com/trustoverip/spec-up.git
DEV_IMAGE ?= trustoverip/specup-devenv
PANDOCS_IMAGE ?= trustoverip/pandocs-devenv
DEV_HOST_DIR ?= host_specup
PUB_HOST_DIR ?= host_pandocs
PUBLISH_DIR ?= publish

# -----------------------------------------------------------------------------
# All Purpose Commands
# -----------------------------------------------------------------------------

help:
	@echo "\n"$(REPO_NAME)"\n"
	@(grep -h "##" Makefile  | tail -6) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# -----------------------------------------------------------------------------
# Targets
# -----------------------------------------------------------------------------

# Clean all build files
clean:
	rm -rf $(PUBLISH_DIR)

# Prepare Git environment
prepare_git:
	git remote remove upstream; git remote add upstream $(UPSTREAM_REPO); git remote -v

# Build all required Docker images
build_images: ./docker/specup/Dockerfile ./docker/pandocs/Dockerfile
	docker build -t $(DEV_IMAGE) -f ./docker/specup/Dockerfile .
	docker build -t $(PANDOCS_IMAGE) -f ./docker/pandocs/Dockerfile .
	docker images | grep -h "trustoverip"

serve_specup: build_images
	-docker kill $(CONTAINER_NAME)
	-docker rm $(CONTAINER_NAME)
	docker run -d --name $(CONTAINER_NAME) -v ${PWD}:/$(DEV_HOST_DIR) -p $(DEV_SITE_PORT):3000 $(DEV_IMAGE)

# Publication directory
prepare_pandocs:
	mkdir -p $(PUBLISH_DIR)

# -----------------------------------------------------------------------------
# Local Environment (Docker Host) Commands
# -----------------------------------------------------------------------------

setup: prepare_git build_images ## Prepare Development and Publication environments

rebase: ## Rebase local machine environment with upstream repo
	git fetch upstream
	git rebase upstream/master; git rebase upstream/main

merge: ## Merge local machine environment with template repo
	git fetch template
	git merge template/main --allow-unrelated-histories

devenv: serve_specup ## Run development environemnt to Generates HTML content
	@echo "Launching Test Server for access via http://localhost:"$(DEV_SITE_PORT)
	docker exec -it $(REPO_NAME) bash

pubenv: clean prepare_pandocs ## Prepare print environemnt
	docker run -ti -v ${PWD}:/$(PUB_HOST_DIR) --entrypoint=/bin/bash $(PANDOCS_IMAGE)

# -----------------------------------------------------------------------------
# PanDoc Container Commands
# -----------------------------------------------------------------------------

publish: ## Generate publication formats (HTML, PDF)
	pandoc -s $(SITE_DIR)/index.html --from html --to markdown_strict -o $(PUBLISH_DIR)/$(REPO_NAME).md
	pandoc $(PUBLISH_DIR)/$(REPO_NAME).md --pdf-engine=xelatex -o $(PUBLISH_DIR)/$(REPO_NAME).pdf
	ls -la $(PUBLISH_DIR)
