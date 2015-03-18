# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Pretty Print ls
alias ls='ls --color=auto'

# [username@host cwd (name only) ]$
PS1='[\u@\h \W]\$ '

# Unlimited History
HISTSIZE=
HISTFILESIZE=

# Arch Specific:
# Correction to: Bundler installs gems system-wide
export GEM_HOME=$(ruby -e 'print Gem.user_dir')

# Add gem to path
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"


# MARKS PLUGIN
# http://jeroenjanssens.com/2013/08/16
# /quickly-navigate-your-filesystem-from-the-command-line.html
# I love this!
export MARKPATH=$HOME/.marks
function j { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
