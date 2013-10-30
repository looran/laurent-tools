PREFIX=/usr/local
BINDIR=$(PREFIX)/bin

BINARIES=dualscreen.sh

all:

install:
	install -m 0755 $(BINARIES) $(BINDIR)
