#! /bin/bash
# file my_vim.sh
# author Jianlong Chen <jianlong99@gmail.com>
# date 2014-02-21

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
cp -r $PLUGINS_DIR/vim-template $HOME/.vim/bundle/
cp -r $PLUGINS_DIR/vim-project $HOME/.vim/bundle/
