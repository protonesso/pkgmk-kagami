#
#  pkgutils
#
#  Copyright (c) 2000-2005 by Per Liden <per@fukt.bth.se>
#  Copyright (c) 2006-2017 by CRUX team (http://crux.nu)
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, 
#  USA.
#

DESTDIR =
PREFIX = /usr
BINDIR = $(PREFIX)/bin
MANDIR = $(PREFIX)/share/man
ETCDIR = /etc

VERSION = 5.43.2
NAME = pkgutils-$(VERSION)

all: pkgmk

pkgmk: pkgmk.in

man: $(MANPAGES)

%: %.in
	sed -e "s/#VERSION#/$(VERSION)/" $< > $@

ifeq (.depend,$(wildcard .depend))
include .depend
endif

.PHONY:	clean distclean dist

dist: distclean
	rm -rf $(NAME) $(NAME).tar.gz
	git archive --format=tar --prefix=$(NAME)/ HEAD | tar -x
	git log > $(NAME)/ChangeLog
	tar cJvf $(NAME).tar.xz $(NAME)
	rm -rf $(NAME)

clean:
	rm -f .depend

distclean: clean
	rm -f pkgmk

# End of file
