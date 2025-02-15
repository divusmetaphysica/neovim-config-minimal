DOTVIM    := $(HOME)/.config/nvim/
DOTVIMRC  := $(HOME)/.config/nvim/init.vim
PACK      := $(DOTVIM)/pack
FTPLUGIN  := $(DOTVIM)/after/ftplugin
PYSTYLE   := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,python))
RUSTSTYLE := $(addprefix $(FTPLUGIN)/,$(addsuffix .vim,c c++ rust lua javascript typescript))

all: langstyles plugins link
.PHONY: all clean pack ftplugin link langstyles plugins $(RUSTSTYLE) $(RUSTSTYLE)

pack:
	mkdir -p $(PACK)

ftplugin:
	mkdir -p $(FTPLUGIN)

vim-surround:
	mkdir -p $(PACK)/tpope/start
	git clone --depth 1 https://tpope.io/vim/surround.git $(PACK)/tpope/start/vim-surround
	vim -u NONE -c "helptags surround/doc" -c q

vim-polyglot:
	mkdir -p $(PACK)/sheeran/start
	git clone --depth 1 https://github.com/sheerun/vim-polyglot $(PACK)/sheeran/start/vim-polyglot
	vim -u NONE -c "helptags polyglot/doc" -c q

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
plugins: pack vim-surround vim-polyglot

clean:
	unlink $(DOTVIM)
	rm -fr .vim/
	unlink $(DOTVIMRC)
