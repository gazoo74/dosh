#!/bin/sh
#
# Copyright (c) 2017 Gaël PORTAY <gael.portay@savoirfairelinux.com>
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the MIT License.
#

PREFIX ?= /usr/local

.PHONY: all
all: dsh.1.gz dmake.1.gz docker-clean.1.gz
	@eval $$(cat /etc/os*release); echo $$NAME

.PHONY: install
install:
	install -d $(DESTDIR)$(PREFIX)/bin/
	install -m 755 dsh dmake $(DESTDIR)$(PREFIX)/bin/
	install -m 755 docker-clean $(DESTDIR)$(PREFIX)/bin/
	install -d $(DESTDIR)$(PREFIX)/share/man/man1/
	install -m 644 dsh.1.gz dmake.1.gz docker-clean.1.gz \
	           $(DESTDIR)$(PREFIX)/share/man/man1/

.PHONY: tests
tests:
	@./tests.sh

.PHONY: check
check: dsh dmake docker-clean
	shellcheck $^

.PHONY:
clean:
	rm -f dsh.1.gz dmake.1.gz docker-clean.1.gz

%.1: %.1.adoc
	asciidoctor -b manpage -o $@ $<

%.gz: %
	gzip -c $^ >$@

