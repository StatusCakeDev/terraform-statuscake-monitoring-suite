SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := help
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
MODULE_DIR ?= .
TERRAFORM ?= terraform
TFTEST ?= tftest

ifeq ($(origin .RECIPEPREFIX), undefined)
	$(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX =

.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@echo "  init   Initialize the Terraform working directory"
	@echo "  docs   Generate documentation for all modules"
	@echo "  format Format the configuration"
	@echo "  test   Validate the configuration"
	@echo "  clean  Clean the Terraform working directory"

# Utility target to force execution. Include this as a dependency for targets
# that need to run unconditionally.
.PHONY: FORCE
FORCE:

.PHONY: init
init: .terraform

.PHONY: docs
docs: README.md

.PHONY: format
format:
	@$(TERRAFORM) fmt -recursive
	echo "Configuration formatted successfully."

.PHONY: test
test:
	@$(TFTEST) --recursive --skip-lint $(MODULE_DIR)

.PHONY: clean
clean:
	@rm -rf .terraform .terraform.lock.hcl

README.md: FORCE
	@terraform-docs . || echo "Failed to generate documentation"

.terraform:
	@echo "Initializing Terraform"
	@$(TERRAFORM) init -backend=false >/dev/null
