#! /bin/bash
# file my_vim.sh
# author Jianlong Chen <jianlong99@gmail.com>
# date 2014-02-21

# plugin list
INSTALL_TEMPLATE_PLUGIN=1
INSTALL_PROJECT_PLUGIN=1
INSTALL_TAGLIST_PLUGIN=1
INSTALL_TAGBAR_PLUGIN=1
INSTALL_GO_PLUGIN=1

TOPDIR=`pwd`
TEMPLATE_DIR=$TOPDIR/templates
PLUGINS_DIR=$TOPDIR/plugins

if [[ "`uname`" == "Darwin" ]]; then
	PKG_MANAGER=port
	PKG_OPTS=
else
	PKG_MANAGER=apt-get
	PKG_OPTS=-y
fi


git submodule init
git submodule update

[ -f $HOME/.vimrc ] && cp $HOME/.vimrc $HOME/".vimrc_backup_`date +%F-%T`"
cp $TEMPLATE_DIR/vimrc-template $HOME/.vimrc
mkdir -p $HOME/.vim/autoload
mkdir -p $HOME/.vim/bundle
cp $PLUGINS_DIR/vim-pathogen/autoload/pathogen.vim $HOME/.vim/autoload/pathogen.vim

# vim-template plugin
if [ $INSTALL_TEMPLATE_PLUGIN -ne 0 ]; then
	rsync -crl --delete $PLUGINS_DIR/vim-template $HOME/.vim/bundle/
fi

# vim-project plugin
if [ $INSTALL_PROJECT_PLUGIN -ne 0 ]; then
	rsync -crl --delete $PLUGINS_DIR/vim-project $HOME/.vim/bundle/
fi

# vim-taglist plugin
if [ $INSTALL_TAGLIST_PLUGIN -ne 0 ]; then
	sudo $PKG_MANAGER install $PKG_OPTS ctags
	rsync -crl --delete $PLUGINS_DIR/vim-taglist $HOME/.vim/bundle/
fi

# vim-tagbar plugin
if [ $INSTALL_TAGLIST_PLUGIN -ne 0 ]; then
	sudo $PKG_MANAGER install $PKG_OPTS ctags
	rsync -crl --delete $PLUGINS_DIR/vim-tagbar $HOME/.vim/bundle/
fi

# vim-go plugin
go version >/dev/null 2>&1
if [ $? -ne 0 ]; then
	HAVE_GO=0
else
	HAVE_GO=1
fi

if [ \( $INSTALL_GO_PLUGIN -ne 0 \) -a \( $HAVE_GO -ne 0 \) ]; then
	sudo $PKG_MANAGER install $PKG_OPTS mercurial
	rsync -crl --delete $PLUGINS_DIR/vim-go $HOME/.vim/bundle/
fi
