# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return



# Safe mv
alias sm='mv -n'

# [username@host cwd (name only) ]$
PS1='[\u@\h \W]\$ '

# Unlimited History
HISTSIZE=
HISTFILESIZE=

# MARKS PLUGIN
# http://jeroenjanssens.com/2013/08/16
# /quickly-navigate-your-filesystem-from-the-command-line.html
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


# OS Specific - this is sort of a pain but that is what you get for using proprietary software ;(
host_name="$(uname)"
if [[ "$host_name" =~ .*Darwin.* ]]; then
   export PATH="$PATH:$HOME/w/brew/bin"
   export PATH="$PATH:$HOME/pack/war/bin"
   alias ls='ls -G'
else
   alias ls='ls --color=auto'
fi
   
