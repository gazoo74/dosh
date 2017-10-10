# Docker Shell

## NAME

[dosh](dosh.1.adoc) - run a user shell in a container with pwd bind mounted

## DESCRIPTION

[dosh](dosh) runs the _command_ process in a container; using the current
_user_, with _pwd_ bind mounted.

## DOCUMENTATION

Build documentation using _build-doc.dosh_ *dosh(1)* script

	$ ./build-doc.dosh
	sha256:ced062433e33

Or using *make(1)* and _Makefile_

	$ make
	asciidoctor -b manpage -o dosh.1 dosh.1.adoc
	gzip -c dosh.1 >dosh.1.gz
	rm dosh.1

## INSTALL

Run the following command to install *dosh(1)*

	$ sudo make install

Traditional variables *DESTDIR* and *PREFIX* can be overridden

	$ sudo make install PREFIX=/opt/dosh

or

	$ make install DESTDIR=$PWD/pkg PREFIX=/usr

## TUNING

### Default Shell Interpreter

[dosh(1)](dosh.1.adoc) uses `/bin/sh` as default interpreter as it is the only
reliable Shell available. The default interpreter can be set by option
`--shell SHELL`; but it needs to be set to every call to *dosh*.

	dosh --shell /bin/bash

Instead, the default interpreter can be set using the `DOSHELL` environment
variable. When this variable is exported, there is no need to override the Shell
interpreter through the command-line.

Adding these two following lines to the Shell `~/.profile` tells *dosh* to uses
`/bin/bash` as Shell interpreter.

	DOSHELL="/bin/bash"
	export DOSHELL

### Docker extra options

Every single [docker(1)](https://github.com/docker/docker) command performed in
[dosh(1)](dosh.1.adoc) can be customized by passing extra arguments thanks its
corresponding **DOSH_DOCKER_xxx_EXTRA_OPTS** environment variable. **xxx**
represents one of the *docker* commands used in *dosh* (*build*, *rmi*, *run*
and *exec*).

_Note:_ Only `DOSH_DOCKER_RUN_EXTRA_OPTS` is relevant for interactive usage.

As an example, consider mapping extra personal *dot-files* to feel at home in
the container.

Adding these two following lines to the Shell `~/.profile` automatically binds
the `~/.ssh` directory to the container.

	DOSH_DOCKER_RUN_EXTRA_OPTS="--volume $HOME/.ssh:$HOME/.ssh"
	export DOSH_DOCKER_RUN_EXTRA_OPTS

### SHELL PROFILE EXAMPLES

Here is an example of code to copy/paste in the `.profile`.

	# Not sh?
	if [ "$SHELL" != "/bin/sh" ]; then
		export DOSHELL="$SHELL"
	fi

	# Export some environment variables
	for env in TERM EDITOR; do
		[ -n "$env" ] || continue
		DOSH_DOCKER_RUN_EXTRA_OPTS+=" --env $env"
	done

	# Map some home dot-files
	for vol in $HOME/.ssh $HOME/.config $HOME/.local $HOME/.profile; do
		[ -e "$vol" ] || continue
		DOSH_DOCKER_RUN_EXTRA_OPTS+=" --volume $vol:$vol"
	done

	# Map bash dot-files
	for vol in $HOME/.bash{_profile,rc,login,logout}; do
		[ -e "$vol" ] || continue
		DOSH_DOCKER_RUN_EXTRA_OPTS+=" --volume $vol:$vol"
	done

	# In docker?
	[ -z "$DOSHLVL" ] || return

	# Update prompt color
	PS1="${PS1//32/33}"

## LINKS

Check for [man-pages](dosh.1.adoc) and its [examples](dosh.1.adoc#examples).

Also, here is an extra example that build the documentation

	$ echo FROM ubuntu >Dockerfile
	$ echo RUN apt-get update && apt-get install -y asciidoctor >>Dockerfile

	$ cat Dockerfile
	FROM ubuntu
	RUN apt-get update && apt-get install -y asciidoctor

	$ dosh -c asciidoctor -b manpage -o - dosh.1.adoc | gzip -c - >dosh.1.gz
	sha256:ced062433e33

	$ man ./dosh.1.gz

Enjoy!

## BUGS

Report bugs at *https://github.com/gazoo74/dosh/issues*

## AUTHOR

Written by Gaël PORTAY *gael.portay@savoirfairelinux.com*

## COPYRIGHT

Copyright (c) 2017 Gaël PORTAY

This program is free software: you can redistribute it and/or modify it under
the terms of the MIT License.
