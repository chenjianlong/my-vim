#! /bin/bash
# file my_vim.sh
# author Jianlong Chen <jianlong99@gmail.com>
# date 2014-02-21

# plugin list
INSTALL_TEMPLATE_PLUGIN=1
INSTALL_PROJECT_PLUGIN=1
INSTALL_TAGLIST_PLUGIN=1

TOPDIR=`pwd`
TEMPLATE_DIR=$TOPDIR/templates
PLUGINS_DIR=$TOPDIR/plugins


git submodule init
git submodule update

[ -f $HOME/.vimrc ] && cp $HOME/.vimrc $HOME/.vimrc_backup
cp $TEMPLATE_DIR/vimrc-template $HOME/.vimrc
mkdir -p $HOME/.vim/autoload
mkdir -p $HOME/.vim/bundle
cp $PLUGINS_DIR/vim-pathogen/autoload/pathogen.vim $HOME/.vim/autoload/pathogen.vim

# vim-template plugin
if [ $INSTALL_TEMPLATE_PLUGIN -ne 0 ]; then
	cp -r --remove-destination $PLUGINS_DIR/vim-template $HOME/.vim/bundle/
fi

# vim-project plugin
if [ $INSTALL_PROJECT_PLUGIN -ne 0 ]; then
	cp -r --remove-destination $PLUGINS_DIR/vim-project $HOME/.vim/bundle/
fi

# vim-taglist plugin
if [ $INSTALL_TAGLIST_PLUGIN -ne 0 ]; then
	sudo apt-get install ctags
	cp -r --remove-destination $PLUGINS_DIR/vim-taglist $HOME/.vim/bundle/
fi
