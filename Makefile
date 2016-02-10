DESTDIR 	= /
SYSCONFDIR 	= etc
PREFIX 		= usr
SBINDIR 	= $(PREFIX)/local/sbin
MANDIR 		= $(PREFIX)/share/man/man8

bash_comp_dir	= $(PREFIX)/share/bash-completion
zsh_comp_dir	= $(PREFIX)/share/zsh/functions/Completion/Unix

apache_conf = $(DESTDIR)/$(SYSCONFDIR)/httpd/conf

all:

install:
	install -dm755 $(apache_conf)/mods-enabled
	install -dm755 $(apache_conf)/mods-available
	install -dm755 $(apache_conf)/sites-enabled
	install -dm755 $(apache_conf)/sites-available
# install a2enmod and create symlinks
	install -Dm755 a2enmod $(DESTDIR)/$(SBINDIR)/a2enmod
	ln -sf a2enmod $(DESTDIR)/$(SBINDIR)/a2ensite
	ln -sf a2enmod $(DESTDIR)/$(SBINDIR)/a2dismod
	ln -sf a2enmod $(DESTDIR)/$(SBINDIR)/a2dissite
# install available modules
	cp -f mods-available/* $(apache_conf)/mods-available/
# install man pages
	install -dm755 $(DESTDIR)/$(MANDIR)
	cp -f man/* $(DESTDIR)/$(MANDIR)/
# install other configuration files
	cp conf/* -fr $(apache_conf)/
# install shell completions
	install completions/bash_completion -Dm755  $(DESTDIR)/$(bash_comp_dir)/a2utils
	install completions/zsh_completion -Dm755  $(DESTDIR)/$(zsh_comp_dir)/_a2utils

uninstall:
	rm -f $(DESTDIR)/$(SBINDIR)/a2enmod
	rm -f $(DESTDIR)/$(SBINDIR)/a2dismod
	rm -f $(DESTDIR)/$(SBINDIR)/a2ensite
	rm -f $(DESTDIR)/$(SBINDIR)/a2dissite
	rm -f $(DESTDIR)/$(MANDIR)/a2dismod.8
	rm -f $(DESTDIR)/$(MANDIR)/a2dissite.8
	rm -f $(DESTDIR)/$(MANDIR)/a2enmod.8
	rm -f $(DESTDIR)/$(MANDIR)/a2ensite.8
	rm -f $(DESTDIR)/$(bash_comp_dir)/a2utils
	rm -f $(DESTDIR)/$(zsh_comp_dir)/_a2utils
