#!/usr/bin/env bash
##############################
# Exports:
# - jr_funct_append_idempotent
#   @see jr_doc_funct_append_idempotent
#
# Requires:
# - jr_funct_file_contains
##############################

alias jr_doc_funct_append_idempotent="echo \"
##########
# Appends a string to a file if the file does not contain the string.
#
# @param1 a path to a file (relative to cwd)
# @param2 a string (multiline works)
# @return
#   - 0 when the string was appended to the file
#   - 1 when the string was already contained in the file
##########\""
jr_funct_append_idempotent(){
    local filePath="${1}"
    local string="${2}"
    if jr_funct_file_contains "${filePath}" "${string}"; then
        return 1
    else
        echo -e "${string}" >> "${filePath}"
        return 0
    fi
}
export -f jr_funct_append_idempotent