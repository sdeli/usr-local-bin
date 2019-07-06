#!/bin/bash

# when opening bash
# check on which wspace are we open
# if wspc 1 check for other terminal on wspace 1
# if there is other terminal on ws 1 than close that terminal 

# Define global variables ======================================================================
filename="wmctrl_list.txt"

# CHECKING ON WHICH WORKSPACE ARE WE ============================================================

function check_current_workspace(){

	wmctrl -d > /usr/local/bin/support-files/${filename}
	sed -i 's/\*/here_we_are/' /usr/local/bin/support-files/${filename}

	function loop_threw_wmctrl_list(){

		local file_length=$(wc -l < /usr/local/bin/support-files/${filename})

		for (( i = 1; i <= $file_length; i++ )); do
			

			local line_array=( `head -n$i /usr/local/bin/support-files/${filename} | tail -1`)
			local new_line_value=$( parse_new_line ${line_array[@]} )

			if [[ $new_line_value = "asterix found" ]]; then
				
				echo "workspace_1"
				return 0
			fi

		done

		echo "not_on_workspace_1"
		return 1

	} # loop_threw_wmctrl_list


	function parse_new_line(){

		local line=($@)

		if [[ ${line[1]} = "here_we_are" && ${line[0]} = "1" ]]; then
			
			echo "asterix found"
			return 0 

		else
				#statements	
			echo "nem talalt"
			return 1
				
		fi

	} # parse_new_line

	check_current_workspace_message=$( loop_threw_wmctrl_list )
	echo $check_current_workspace_message
	return $?
} # check_current_workspace



# IF WE ARE ON WORKSPACE 1 CHECK IF THERE IS A TERMINAL WINDOW ON WORKSPACE_1 =========================
function check_if_terminal_on_wsp(){

	wmctrl -l > /usr/local/bin/support-files/${filename}

	function loop_threw_wmctrl_list(){

		local file_length=$(wc -l < /usr/local/bin/support-files/${filename})

		for (( i = 1; i <= $file_length; i++ )); do
			
			local line_array=( `head -n$i /usr/local/bin/support-files/${filename} | tail -1`)

			local new_line_value=$( parse_new_line ${line_array[@]} )

			if [[ $new_line_value = "terminal found" ]]; then
				
				echo "terminal found"
				return 0
			fi

		done

		echo "terminal not found"
		return 1

	} # loop_threw_wmctrl_list


	function parse_new_line(){

		local line=($@)

		for (( i = 0; i < ${#line[@]}; i++ )); do
			#statements
			if [[ ${line[$i]} = "vs-terminal" ]]; then
				
				echo "terminal found"
				return 0 

			fi

		done

		echo "nem talat"
		return 1

	} # parse_new_line
	
	check_if_terminal_on_wsp_message=$( loop_threw_wmctrl_list )
	echo $check_if_terminal_on_wsp_message
	return $?

} # check_if_terminal_on_wsp()


# CALL FUNCTIONS ===================================================================== 

IF_ON_WORKSPACE_1=$( check_current_workspace )

if [[ $IF_ON_WORKSPACE_1 = "workspace_1" ]]; then
	#statements
	IF_TERMINAL_EXIST=$( check_if_terminal_on_wsp )	
	echo $IF_TERMINAL_EXIST >> '/usr/local/bin/support-files/log-open-close-terminal.log'

	if [[ $IF_TERMINAL_EXIST = "terminal found" ]]; then
		wmctrl -c "vs-terminal"
	fi

fi

exit $?

#	echo $check_if_terminal_on_wsp_message > '/usr/local/bin/support-files/log-open-close-terminal.log'