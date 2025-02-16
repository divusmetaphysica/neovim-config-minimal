DOTVIM    := $(HOME)/.config/nvim/
DOTVIMRC  := $(HOME)/.config/nvim/init.vim
PACK      := $(DOTVIM)/pack
FTPLUGIN  := $(DOTVIM)/after/ftplugin
PYSTYLE   := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,python))
RUSTSTYLE := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,c c++ rust lua javascript typescript))

all: langstyles plugins link
.PHONY: all clean ftplugin link langstyles plugins $(RUSTSTYLE) $(RUSTSTYLE)

ftplugin:
	mkdir -p $(FTPLUGIN)

plugins:
	mkdir -p $(PACK)/plugins/start
	git clone --depth 1 https://tpope.io/vim/surround.git $(PACK)/plugins/start/vim-surround
	vim -u NONE -c "helptags surround/doc" -c q
	git clone --depth 1 https://github.com/sheerun/vim-polyglot $(PACK)/plugins/start/vim-polyglot
	vim -u NONE -c "helptags polyglot/doc" -c q
	git clone --depth 1 https://github.com/vim-syntastic/syntastic $(PACK)/plugins/start/syntastic
	vim -u NONE -c "helptags syntastic/doc" -c q
	git clone --depth 1 https://github.com/itchyny/lightline.vim $(PACK)/plugins/start/lightline
	vim -u NONE -c "helptags lightline/doc" -c q

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

link:
	ln -s $(abspath .vimrc) $(DOTVIMRC)

langstyles: ftplugin $(RUSTSTYLE) $(PYSTYLE)

clean:
	unlink $(DOTVIM)
	rm -fr .vim/
	unlink $(DOTVIMRC)
