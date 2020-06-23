BUNDLE    := .vim/bundle
FTPLUGIN  := .vim/after/ftplugin
DOTVIM    := $(HOME)/.vim
DOTVIMRC  := $(HOME)/.vimrc
SYMLINKS  := $(DOTVIM) $(DOTVIMRC)
CSTYLE    := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,c c++))
PYSTYLE   := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,python))
RUSTSTYLE := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,rust lua javascript typescript))
BUILDTLS  := build-essential cmake python3-dev
CLANGTLS  := clang-7 clang-tidy-7 clang-tools-7 libclang1-7

all: apt_libs $(BUNDLE) $(BUNDLE)/Vundle.vim plugin_install $(SYMLINKS) langstyles
.PHONY: all apt_libs clean plugin_install langstyles

$(BUNDLE):
	mkdir -p $(BUNDLE)

$(BUNDLE)/Vundle.vim:
	git clone https://github.com/VundleVim/Vundle.vim $(BUNDLE)/Vundle.vim

$(DOTVIM):
	ln -s $(abspath .vim) $@

$(DOTVIMRC):
	ln -s $(abspath .vimrc) $@

apt_libs:
	sudo apt update
	sudo apt install $(BUILDTLS)
	sudo apt install $(CLANGTLS) 

plugin_install:
	vim +PluginInstall +PluginUpdate +PluginClean +qall

clean:
	unlink $(HOME)/.vim
	rm -fr .vim/
	unlink $(HOME)/.vimrc

langstyles: ftplugins $(CSTYLE) $(RUSTSTYLE) $(PYSTYLE)

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
