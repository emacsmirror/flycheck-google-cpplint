SHELL := /usr/bin/env bash

EMACS ?= emacs
EASK ?= eask

TEST-FILES := $(shell ls test/flycheck-google-cpplint-*.el)

.PHONY: clean package install compile checkdoc lint unix-test

ci: clean package install compile

package:
	@echo "Packaging..."
	$(EASK) autoloads
	$(EASK) pkg-file
	$(EASK) package

clean:
	@echo "Cleaning..."
	$(EASK) clean-all

install:
	@echo "Installing..."
	$(EASK) install

compile:
	@echo "Compiling..."
	$(EASK) compile

lint:
	@echo "Linting..."
	$(EASK) lint

unix-test:
	@echo "Testing..."
	$(EASK) exec ert-runner -L . $(LOAD-TEST-FILES) -t '!no-win' -t '!org'
