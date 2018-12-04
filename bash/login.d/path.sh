# Extensions to the default $PATH

__df_add_to_path() {
	if [ -d "${1}" ]; then
		PATH="${1}:${PATH}"
	fi
}

__df_add_to_path "${HOME}/bin"

unset __df_add_to_path
