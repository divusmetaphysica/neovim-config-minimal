# Setup minimal vim editor
# 
# Just run this setup script. TO clean up you can remove these files
#
# unlink $DOTVIM
# rm -fr .vim/
# unlink $DOTVIMRC
#
DOTVIM=$HOME/.vim
DOTVIMRC=$HOME/.vimrc
#
PACK=.vim/pack/start
FTPLUGIN=.vim/after/ftplugin
#
declare -a PYSTYLE=($FTPLUGIN/python.vim)
declare -a RUSTSTYLE=($FTPLUGIN/c.vim $FTPLUGIN/c++.vim $FTPLUGIN/rust.vim $FTPLUGIN/lua.vim $FTPLUGIN/javascript.vim $FTPLUGIN/typescript.vim)
#
#
mkdir -p $PACK
mkdir -p $FTPLUGIN
#
git clone git@github.com:tpope/vim-surround.git $HOME/$PACK
git clone git@github.com:sheerun/vim-polyglot.git $HOME/$PACK
#
for i in "${PYSTYLE[@]}"
do 
	touch $i
	echo "setlocal expandtab" >> $i
	echo "setlocal shiftwidth=4" >> $i
	echo "setlocal softtabstop=4" >> $i
done
#
for i in "${RUSTSTYLE[@]}"
do 
	touch $i
	echo "setlocal expandtab" >> $i
	echo "setlocal shiftwidth=2" >> $i
	echo "setlocal softtabstop=2" >> $i
done
#
ln -s .vim $DOTVIM
ln -s .vimrc $DOTVIMRC


