#!/bin/sh

exec_command()
{
    cmd=$1
    echo $cmd
    $cmd
}

DOTFILES_DIR=`pwd`/${0%/*}

DOTFILES=( .zsh .vim .vimrc .screenrc .tmux.conf .gitconfig )
for file in ${DOTFILES[@]}
do
    if [ -a $HOME/$file ]; then
        if [ -L $HOME/$file ]; then
            echo "already symbolic link exists: $file"
        elif [ -d $HOME/$file ]; then
            echo "already directory exists: $file"
        else
            echo "already file exists: $file"
        fi
    else
        exec_command "ln -s $DOTFILES_DIR/$file $HOME"
    fi
done

# for zsh
ZSH_DOTFILES=( .zshenv .zshrc )
for zfile in ${ZSH_DOTFILES[@]}
do
    if [ ! -f $HOME/$zfile ]; then
        exec_command "ln -s $DOTFILES_DIR/.zsh/$zfile $HOME"
    else
        echo "already file exists: $zfile"
    fi
done
exec_command "touch $HOME/.zshrc.local"

# for vim vundle
if [ ! -d $DOTFILES_DIR/.vim/bundle ]; then
    mkdir $DOTFILES_DIR/.vim/bundle
fi
#exec_command "git submodule init"
#exec_command "git submodule update"

