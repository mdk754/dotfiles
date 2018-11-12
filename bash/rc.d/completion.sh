if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Add tab completion for SSH hostnames.
if [ -e "${HOME}/.ssh/config" ]; then
	complete -o "default" -o "nospace" -W "$(grep "^Host" ${HOME}/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh
fi

# Add `killall` tab completion for common apps.
complete -o "nospace" -W "code firefox subl" killall
