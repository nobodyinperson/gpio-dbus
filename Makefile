#!/usr/bin/make -f

# directories
LANGDIR = usr/share/gpio-dbus/lang
DOCDIR  = usr/share/doc/gpio-dbus/manpages

# the changelog
CHANGELOG = debian/changelog

# all pofiles
POFILES = $(shell find $(LANGDIR) -type f -iname '*.po')
# the corresponding mofiles
MOFILES = $(POFILES:.po=.mo)

# all markdown manpages
MDMANPAGES = $(shell find $(DOCDIR) -type f -iname '*.1.md')
# corresponding groff manpages
GFMANPAGES = $(MDMANPAGES:.1.md=.1)

# source files that contain translatable text - the _(...) function
# that is, all python files
PYTHONFILES = $(shell find usr -type f -exec file {} \; | perl -ne 'print if s/^([^:]+):.*python.*$$/$$1/ig')

# temporary pot-file template
POTFILE = usr/share/gpio-dbus/lang/gpio-dbus.pot

# get information from changelog
GPIODBUSVERSION = $(shell perl -ne 'if(s/^gpio-dbus\s*\((.*?)\).*$$/$$1/g){print;exit}' $(CHANGELOG))
GPIODBUSDATE    = $(shell perl -ne 'if(s/^\s*--.*@.*,\s*(.*)$$/$$1/g){print;exit}' $(CHANGELOG))

# pandoc options for manpage creation
PANDOCOPTS = -f markdown -t man --standalone -Vfooter='Version $(GPIODBUSVERSION)' -Vdate='$(GPIODBUSDATE)'
 
all: $(MOFILES) $(GFMANPAGES)

# build the manpages
# manpages:
%.1: %.1.md
	pandoc $(PANDOCOPTS) -o $@ $<

# create the pot-file with all translatable strings from the srcfiles
$(POTFILE): $(PYTHONFILES)
	xgettext -L Python -o $(POTFILE) $(PYTHONFILES)

# update the translated catalog
%.po: $(POTFILE)
	VERSION_CONTROL=off msgmerge -U --backup=off $@ $<

# compile the translations
%.mo: %.po
	msgfmt -o $@ $<


.PHONY: clean
clean:
	rm -f $(MOFILES)
	rm -f $(POTFILE)
	rm -f $(GFMANPAGES)


	
