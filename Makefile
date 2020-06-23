FTPLUGIN=.vim/after/ftplugin
DIRS=$(FTPLUGIN)
SYMLINKS=$(HOME)/.vim $(HOME)/.vimrc
CSTYLE=$(FTPLUGIN)/c.vim $(FTPLUGIN)/c++.vim
PYSTYLE=$(FTPLUGIN)/python.vim
RUSTSTYLE=$(FTPLUGIN)/rust.vim

all: $(DIRS) $(SYMLINKS)
.PHONY: all clean

$(DIRS):
	mkdir -p $@ 

$(SYMLINKS):
	ln -s $(abspath .vim) $@

clean:
	unlink ~/.vim
	rm -fr .vim/
	unlink ~/.vimrc

langstyles: ftplugins $(CSTYLE) $(RUSTSTYLE) $(PYSTYLE)
.PHONY: langstyles

ftplugins:
	mkdir -p $(FTPLUGIN)

$(CSTYLE):
	touch $@
	echo "setlocal noexpandtab" >> $@
	echo "setlocal shiftwidth=2" >> $@
	echo "setlocal softtabstop=2" >> $@

$(RUSTSTYLE):
	touch $@
	echo "setlocal expandtab" >> $@
	echo "setlocal shiftwidth=2" >> $@
	echo "setlocal softtabstop=2" >> $@

$(PYSTYLE): 
	touch $@
	echo "setlocal expandtab" >> $@
	echo "setlocal shiftwidth=4" >> $@
	echo "setlocal softtabstop=4" >> $@
