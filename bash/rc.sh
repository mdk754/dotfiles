# Interactive shell startup file.

__df_current_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))

# If the shell is non-interactive exit early.
if [[ $- != *i* ]]; then
	return
fi

# Load all files from the rc.d directory.
if [ -d "${__df_current_dir}/rc.d" ]; then
	for file in ${__df_current_dir}/rc.d/*.sh; do
		[ -e "${file}" ] && . "${file}"
	done
	unset file
fi

unset __df_current_dir
