# -------------------------------------------------------------------
# function
# -------------------------------------------------------------------
# 補完機能を有効にする
autoload -U compinit
compinit -d /tmp/$USER.zcompdump
# プロンプトのカラー表示用関数
autoload -U colors
colors

# -------------------------------------------------------------------
# Environment variable
# -------------------------------------------------------------------
export LANG=ja_JP.UTF-8
export PATH=/usr/local/bin:${PATH}:/sbin:/usr/sbin:${HOME}/bin

# -------------------------------------------------------------------
# Alias
# -------------------------------------------------------------------
alias ls="ls -F"
alias ll="ls -l"
alias la="ls -la"
alias du="du -h"
alias df="df -h"
alias rm="rm -i"
alias sc="screen"

# svn
alias svnst="svn status"
alias svnup="svn update"
alias svnadd="svn add"
alias svncp="svn copy"
alias svnrev="svn revert"
alias svnci="svn commit"
alias svndiff="svn diff"
alias svnaddall="svn add --force"
alias svnrevall="svn revert --recursive"

# git
alias gitst="git st"

# tmux
#alias tmux='tmuxx'
alias tmls="tmux list-sessions"
alias tmat="tmux attatch"
alias tmnew="tmux new-session"
alias tmrn="tmux rename-session -t"
alias tmkill="tmux kill-session -t"
alias tmkillall="tmux kill-server"

# -------------------------------------------------------------------
# PROMPT
# -------------------------------------------------------------------
#PROMPT="%{${fg[yellow]}%}%n@%m[%~]%#%{${reset_color}%} "
PROMPT="%{${fg[red]}%}%n@%m[%~]$%{${fg[default]}%} "
#PROMPT2=
#PROMPT3=
#PROMPT4
#RPS1
#SPROMPT=

# -------------------------------------------------------------------
# Option
# -------------------------------------------------------------------
# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups      # 直前のヒストリと同一ならば無視する
setopt hist_ignore_space     # 先頭がスペースならば無視する
#setopt hist_expand           # ?
setopt share_history         # ヒストリーを複数zshプロセス間で共有する

setopt auto_pushd            # ディレクトリの移動履歴一覧を"cd [TAB]"で表示
setopt auto_cd               # ディレクトリ名でcdが可能になる
setopt correct               # コマンド入力ミスを指摘してくれる
setopt list_packed           # タブ補完候補を詰めて表示する
setopt list_types            # ファイル種別を示す記号を末尾に表示する
#setopt pushd_ignore_dups     # ^Iで補完可能な一覧を表示する
setopt no_beep               # ベルを鳴らさない
#setopt ignore_eof            # ^Dでログアウトしない
setopt extended_glob         # "#","~","^"を正規表現として扱う
setopt rm_star_silent        # "rm * "を実行する前に確認

# -------------------------------------------------------------------
# CVS
# -------------------------------------------------------------------
#export CVSROOT=
#export CVS_RSH='ssh'
#export CVSEDITOR='vim'

# -------------------------------------------------------------------
# SVN
# -------------------------------------------------------------------
export SVN_EDITOR='vim'

# -------------------------------------------------------------------
# Git
# -------------------------------------------------------------------
export PATH=$PATH:/usr/local/git/bin
export MANPATH=$MANPATH:/usr/local/git/man

# -------------------------------------------------------------------
# Java, Tomcat
# -------------------------------------------------------------------
#export JAVA_HOME=/usr/java/jdk
#export PATH=$PATH:$JAVA_HOME/bin
#export CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
#export TOMCAT_HOME=/usr/local/server/tomcat
#export CATALINA_HOME=/usr/local/server/tomcat
#export CLASSPATH=$CLASSPATH:$CATALINA_HOME/common/lib:$CATALINA_HOME/common/lib/servlet-api.jar

# -------------------------------------------------------------------
# Python
# -------------------------------------------------------------------
#export PYTHONHOME=
#export PYTHONPATH=

# -------------------------------------------------------------------
# Rvm
# -------------------------------------------------------------------
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
#[ -s $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm

# -------------------------------------------------------------------
# ローカル設定読み込み
# -------------------------------------------------------------------
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

