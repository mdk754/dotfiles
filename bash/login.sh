# Login shell startup file.

__df_current_dir="$(dirname $(readlink -f "${BASH_SOURCE[0]}"))"

# Load all files from the login.d directory.
if [ -d "${__df_current_dir}/login.d" ]; then
	for file in ${__df_current_dir}/login.d/*.sh; do
		[ -e "${file}" ] && . "${file}"
	done
fi

# Source our bashrc if it exists.
[ -f "${HOME}/.bashrc" ] && . "${HOME}/.bashrc"

unset __df_current_dir
