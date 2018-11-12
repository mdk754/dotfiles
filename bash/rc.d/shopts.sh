# If necessary, update the values of LINES and COLUMNS after each command.
shopt -s checkwinsize

# Append to the Bash history file, rather than overwriting it.
shopt -s histappend

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Limit the size of command history.
HISTSIZE=16384
HISTFILESIZE=32768

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell

# Case-insensitive globbing (used in pathname expansion.)
shopt -s nocaseglob

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for __df_option in autocd globstar; do
	shopt -s "${__df_option}" 2> /dev/null
done
unset __df_option
