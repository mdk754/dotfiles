__df_time_preexec() {
    LAST_COMMAND_EXEC_TIME=$(($(date +%s%N) / 1000000))
}

__df_time_precmd() {
	local current_time elapsed_time
	local msec_in_sec msec_in_min msec_in_hour msec_in_day
	local elapsed_days elapsed_hours elapsed_mins elapsed_secs elapsed_millis
	local time_str

    if [ ${LAST_COMMAND_EXEC_TIME} ]; then
        # Store cursor position.
        printf "\n\e[s"

        # Calculate the time elapsed since command started.
		current_time=$(($(date +%s%N) / 1000000))
		elapsed_time=$((${current_time} - ${LAST_COMMAND_EXEC_TIME}))

		# Helpers for calculating time units.
        msec_in_sec=1000
		msec_in_min=60000
		msec_in_hour=3600000
		msec_in_day=86400000

        # Calculate each time unit.
		elapsed_days=$(expr ${elapsed_time} / ${msec_in_day})
		elapsed_hours=$(expr ${elapsed_time} % ${msec_in_day} / ${msec_in_hour})
		elapsed_mins=$(expr ${elapsed_time} % ${msec_in_hour} / ${msec_in_min})
		elapsed_secs=$(expr ${elapsed_time} % ${msec_in_min} / ${msec_in_sec})
		elapsed_millis=$(expr ${elapsed_time} % ${msec_in_sec})

        # Put the time into a string for printing.
		time_str=""
		if [ $elapsed_days -gt 0 ]; then
			time_str=${time_str}${elapsed_days}"d "
		fi
		if [ $elapsed_hours -gt 0 ]; then
			time_str=${time_str}${elapsed_hours}"h "
		fi
		if [ $elapsed_mins -gt 0 ]; then
			time_str=${time_str}${elapsed_mins}"m "
		fi
        if [ $elapsed_secs -gt 0 ]; then
			time_str=${time_str}${elapsed_secs}"s "
		fi
		time_str=${time_str}${elapsed_millis}"ms"

        # Print the time, right aligned.
		printf "%${COLUMNS}.${COLUMNS}s" "[ ${time_str} ] "

        # Restore the cursor position prior to printing.
        printf "\e[u"

		unset LAST_COMMAND_EXEC_TIME
	fi
}

precmd_functions+=(__df_time_precmd)
preexec_functions+=(__df_time_preexec)
