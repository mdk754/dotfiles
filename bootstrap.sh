#!/usr/bin/env bash

current_dir=$(dirname $(readlink -f "${BASH_SOURCE[0]}"))
backup_dir="${current_dir}/backup"

create-backup-dir() {
	mkdir -p "${backup_dir}"
}

create-link() {
	local target="${HOME}/${2}"
	local backup_file="${backup_dir}/${2}"
	local new_file="${current_dir}/${1}"

	[ -h "${target}" ] && rm "${target}"
	[ -f "${target}" ] && mv -i "${target}" "${backup_file}"

	ln -s "${new_file}" "${target}"
}

copy-file() {
	local target="${HOME}/${2}"
	local backup_file="${backup_dir}/${2}"
	local new_file="${current_dir}/${1}"

	[ -h "${target}" ] && rm "${target}"
	[ -f "${target}" ] && mv -i "${target}" "${backup_file}"

	cp "${new_file}" "${target}"
}

bs-copy() {
	return 0
}

bs-symlink() {
	create-link "bash/login.sh" ".bash_profile"
	create-link "bash/rc.sh" ".bashrc"
	create-link "bash/input.sh" ".inputrc"

	create-link "git/config" ".gitconfig"
	create-link "git/ignore" ".gitignore"

	create-link "fonts/" ".fonts"
}

bs-init() {
	return 0
}

bs-install() {
	create-backup-dir

	printf "Copying files … "
	bs-copy || { printf "✖\n" && return 1; }
	printf "✔\n"

	printf "Symlinking files … "
	bs-symlink || { printf "✖\n" && return 1; }
	printf "✔\n"

	printf "Initializing … "
	bs-init || { printf "✖\n" && return 1; }
	printf "✔\n"

	printf "\nBootstrapping has been completed successfully!\n"
}

main() {
	if [ "${1}" == "--force" -o "${1}" == "-f" ]; then
		bs-install
	else
		read -p "This may overwrite existing files in your home directory. Are you sure? (y/N) " -n 1;
		printf "\n"
		if [[ ${REPLY} =~ ^[Yy]$ ]]; then
			printf "\n"
			bs-install
		else
			return 1
		fi
	fi

	return $?
}

main "${@}"
