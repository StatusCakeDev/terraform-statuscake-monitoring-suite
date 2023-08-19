SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DEFAULT_GOAL := check
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules
TERRAFORM := terraform

ifeq ($(origin .RECIPEPREFIX), undefined)
  $(error This Make does not support .RECIPEPREFIX. Please use GNU Make 4.0 or later)
endif
.RECIPEPREFIX =

.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo
	@echo "Targets:"
	@echo "  init     Initialize the Terraform working directory"
	@echo "  check    Check if the configuration is well formatted (default)"
	@echo "  format   Format the configuration"
	@echo "  validate Validate the configuration"
	@echo "  clean    Clean the Terraform working directory"

.PHONY: init
init:
	$(TERRAFORM) init -backend=false

.PHONY: check
check:
	$(TERRAFORM) fmt -check -recursive

.PHONY: format
format:
	$(TERRAFORM) fmt -recursive

.PHONY: validate
validate: init
	$(TERRAFORM) validate

.PHONY: clean
clean:
	@rm -rf .terraform
