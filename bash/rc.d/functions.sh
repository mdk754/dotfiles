# Check if a command exists.
command-exists() {
	command -v "$1" 2>&1 > /dev/null
	return $?
}

# Create a .tar.gz archive, using `zopfli`, `pigz` or `gzip` for compression
tgz() {
	local __df_file="${@%/}.tar"

	printf "Creating ${__df_file} … "
	tar -cf "${__df_file}" "${@}" || { printf "✖\n" && return 1; }
	printf "✔\n"

	local __df_size=$(stat -c"%s" "${__df_file}" 2> /dev/null)
	local __df_command=""

	if (( __df_size < 52428800 )) && command-exists zopfli; then
		__df_command="zopfli"
	else
		if command-exists pigz; then
			__df_command="pigz"
		else
			__df_command="gzip"
		fi
	fi

	printf "Compressing ${__df_file} ($((__df_size / 1024)) kB) using \`${__df_command}\` … "
	"${__df_command}" "${__df_file}" || { printf "✖\n" && return 1; }
	printf "✔\n"

	[ -f "${__df_file}" ] && rm "${__df_file}"

	__df_size=$(stat -c"%s" "${__df_file}.gz" 2> /dev/null)

	printf "\n${__df_file}.gz ($((__df_size / 1024)) kB) created successfully.\n"
}

# Start an HTTP server from the current directory.
http-server() {
	local __df_port="${1:-8080}"

	python -m SimpleHTTPServer ${__df_port}
}
