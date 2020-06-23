BUNDLE=.vim/bundle
FTPLUGIN=.vim/after/ftplugin
SYMLINKS=CSTYLE=$(FTPLUGIN)/c.vim $(FTPLUGIN)/c++.vim
PYSTYLE=$(FTPLUGIN)/python.vim
RUSTSTYLE=$(FTPLUGIN)/rust.vim

all: apt_libs $(BUNDLE) $(BUNDLE)/Vundle.vim plugin_install $(HOME)/.vim $(HOME)/.vimrc
.PHONY: all apt_libs clean plugin_install

$(BUNDLE):
	mkdir -p $(BUNDLE)

$(BUNDLE)/Vundle.vim:
	git clone git@github.com:VundleVim/Vundle.vim $(BUNDLE)/Vundle.vim

$(HOME)/.vim $(HOME)/.vimrc:
	ln -s $(abspath .vim) $(HOME)/.vim
	ln -s $(abspath .vimrc) $(HOME)/.vimrc

apt_libs:
	sudo apt update
	sudo apt install build-essential cmake python3-dev
	sudo apt install clang-7 clang-tidy-7 clang-tools-7 libclang1-7

plugin_install:
	vim +PluginInstall +PluginUpdate +PluginClean +qall

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
