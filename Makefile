# st - simple terminal
# See LICENSE file for copyright and license details.
.POSIX:

include config.mk

SRC = st.c x.c
OBJ = $(SRC:.c=.o)

all: options st

options:
	@echo st build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

st.o: config.h st.h win.h
x.o: arg.h config.h st.h win.h

$(OBJ): config.h config.mk

ifeq ($(OS), Darwin)
all: st $(APPBUNDLE)

$(APPBUNDLE):
	test -d $(APPBUNDLE) && rm -r $(APPBUNDLE); \
	mkdir -p ./$(APPBUNDLE)/Contents/{MacOS,Resources}
	cp ./st ./$(APPBUNDLE)/Contents/MacOS/st
	cp ./st.icns ./$(APPBUNDLE)/Contents/Resources/st.icns
	sed "s/VERSION/$(VERSION)/" < Info.plist.tmpl > ./$(APPBUNDLE)/Contents/Info.plist
endif

st: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	test -d $(APPBUNDLE) && rm -r $(APPBUNDLE); \
	rm -f st $(OBJ) st-$(VERSION).tar.gz

dist: clean
	mkdir -p st-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README config.mk\
		config.def.h st.info st.1 arg.h st.h win.h $(SRC)\
		st-$(VERSION)
	tar -cf - st-$(VERSION) | gzip > st-$(VERSION).tar.gz
	rm -rf st-$(VERSION)

install: st $(APPBUNDLE)
	test -d /Applications/$(APPBUNDLE) && rm -rf /Applications/$(APPBUNDLE); \
	test -d $(APPBUNDLE) && cp -r $(APPBUNDLE) /Applications/$(APPBUNDLE) || echo "$(APPBUNDLE) not found"
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f st $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/st
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < st.1 > $(DESTDIR)$(MANPREFIX)/man1/st.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/st.1
	@echo Please see the README file regarding the terminfo entry of st.
	tic -sx st.info

.PHONY: uninstall
uninstall:
	if [ "$(OS)" == "Darwin" ]; then \
		rm -rf /Applications/$(APPBUNDLE); \
	fi

	rm -f $(DESTDIR)$(PREFIX)/bin/st
	rm -f $(DESTDIR)$(MANPREFIX)/man1/st.1

.PHONY: all options clean dist install uninstall
