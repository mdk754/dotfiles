if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color'
fi

__df_prompt_git() {
	local __df_git_stats=''
	local __df_branch_name=''

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				__df_git_stats+='+'
			fi

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				__df_git_stats+='!'
			fi

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				__df_git_stats+='?'
			fi

			# Check for stashed files.
			if [ $(git rev-parse --verify refs/stash &>/dev/null) ]; then
				__df_git_stats+='$'
			fi
		fi

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		__df_branch_name="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${__df_git_stats}" ] && __df_git_stats=" [${__df_git_stats}]"

		printf "${1}${__df_branch_name}${2}${__df_git_stats}"
	else
		return
	fi
}

__df_reset="\e[0m"
__df_bold='\e[1m'
__df_black="\e[38;5;0m"
__df_blue="\e[38;5;33m"
__df_cyan="\e[38;5;37m"
__df_green="\e[38;5;154m"
__df_orange="\e[38;5;166m"
__df_purple="\e[38;5;129m"
__df_red="\e[38;5;126m"
__df_violet="\e[38;5;61m"
__df_white="\e[38;5;15m"
__df_yellow="\e[38;5;136m"

# Highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then
	__df_user_style="${__df_red}"
else
	__df_user_style="${__df_orange}"
fi

# Highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then
	__df_host_style="${__df_red}"
else
	__df_host_style="${__df_yellow}"
fi

# Set the terminal title to the working directory basename.
PS1="\[\033]0;\W\007\]"

# Set the prompt.
PS1+="\[${__df_bold}\]"
PS1+="\[${__df_user_style}\]\u"
PS1+="\[${__df_white}\] at "
PS1+="\[${__df_host_style}\]\h"
PS1+="\[${__df_white}\] in "
PS1+="\[${__df_green}\]\w"
PS1+="\$(__df_prompt_git \"\[${__df_white}\] on \[${__df_violet}\]\" \"\[${__df_blue}\]\")"
PS1+="\n"
PS1+="\[${__df_white}\]\$ \[${__df_reset}\]"

# Set the prompt continuation.
PS2="\[${__df_yellow}\]→ \[${__df_reset}\]"

export PS1
export PS2
