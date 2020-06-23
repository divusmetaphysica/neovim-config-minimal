FTPLUGIN=.vim/after/ftplugin
CSTYLE=$(FTPLUGIN)/c.vim $(FTPLUGIN)/c++.vim
PYSTYLE=$(FTPLUGIN)/python.vim
RUSTSTYLE=$(FTPLUGIN)/rust.vim

all: ftplugins $(HOME)/.vim $(HOME)/.vimrc
.PHONY: all clean

$(HOME)/.vim $(HOME)/.vimrc:
	ln -s $(abspath .vim) $(HOME)/.vim
	ln -s $(abspath .vimrc) $(HOME)/.vimrc

clean:
	unlink $(HOME)/.vim
	rm -fr .vim/
	unlink $(HOME)/.vimrc

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
