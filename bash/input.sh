# Make Tab autocomplete regardless of filename case.
set completion-ignore-case on

# List all matches in case multiple completions are possible.
set show-all-if-ambiguous on

# Immediately add a trailing slash when autocompleting symlinks to directories.
set mark-symlinked-directories on

# More intelligent Up/Down behavior.
"\e[B": history-search-forward
"\e[A": history-search-backward
"\e[C": forward-char
"\e[D": backward-char

# Do not autocomplete hidden files unless the pattern begins with a dot.
set match-hidden-files off

# Show all autocomplete results at once.
set page-completions off

# If there are too many possible completions for a word, ask to show them all.
set completion-query-items 50

# Use elipsis if the common prefix is long.
set completion-prefix-display-length 3

# Show extra file information when completing, like `ls -F` does.
set visible-stats on

# Display possible completions using colors to indicate their file types.
set colored-stats on

# Be more intelligent when autocompleting by also looking at the text after
# the cursor. For example, when the current line is "cd ~/src/mozil", and
# the cursor is on the "z", pressing Tab will not autocomplete it to "cd
# ~/src/mozillail", but to "cd ~/src/mozilla". (This is supported by the
# Readline used by Bash 4.)
set skip-completed-text on

# Allow UTF-8 input and output, instead of showing stuff like $'\0123\0456'
set input-meta on
set output-meta on
set convert-meta off
