include .env

.DEFAULT_GOAL := help
.ONESHELL:
MAKEFLAGS += --no-print-directory

include ./make/help.mk
include ./make/logs.mk
include ./make/hooks.mk
include ./make/fail2ban.mk