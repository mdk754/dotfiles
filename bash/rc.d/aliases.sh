# Enable color support of ls and also add handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Some more ls aliases.
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map='xargs -n1'

# Reload the shell, add `-l` for login shell.
alias reload='exec ${SHELL}'

# Print each PATH entry on a separate line
alias path='printf ${PATH//:/\\n}'
