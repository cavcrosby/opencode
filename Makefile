# special makefile variables
.DEFAULT_GOAL := help
.RECIPEPREFIX := >

# recursively expanded variables
SHELL = /usr/bin/sh

# targets
HELP = help
SETUP = setup
IMAGE = image
SERVE = serve
CLEAN = clean

# executables
PYTHON = python
PIP = pip
PRE_COMMIT = pre-commit
NPM = npm
DOCKER = docker
MSB = msb

# simply expanded variables
executables := \
	${PYTHON}\
	${NPM}\
	${DOCKER}

_check_executables := $(foreach exec,${executables},$(if $(shell command -v ${exec}),pass,$(error "No ${exec} in PATH")))

.PHONY: ${HELP}
${HELP}:
	# inspired by the makefiles of the Linux kernel and Mercurial
>	@printf '%s\n' 'Common make targets:'
>	@printf '%s\n' '  ${SETUP}                 - install the distro-independent dependencies for this'
>	@printf '%s\n' '                          repository'
>	@printf '%s\n' '  ${IMAGE}                 - make the repository'\''s container image'
>	@printf '%s\n' '  ${CLEAN}                 - remove files generated from targets'

.PHONY: ${SETUP}
${SETUP}:
>	${NPM} install
>	${PYTHON} -m ${PIP} install --upgrade "${PIP}"
>	${PYTHON} -m ${PIP} install --requirement "./requirements-dev.txt"
>	${PRE_COMMIT} install

.PHONY: ${IMAGE}
${IMAGE}:
>	${DOCKER} build --tag "cavcrosby/opencode:latest" "${CURDIR}"
>	${DOCKER} save "cavcrosby/opencode:latest" | ${MSB} load

.PHONY: ${CLEAN}
${CLEAN}:
>	${DOCKER} rmi --force "cavcrosby/opencode:latest"
