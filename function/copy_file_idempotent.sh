#!/usr/bin/env bash
##############################
# Exports:
# - jr_funct_copy_file_idempotent
#   @see jr_doc_funct_copy_file_idempotent
##############################



alias jr_doc_funct_copy_file_idempotent="echo \"
##########
# Copies a file to a destination if the destination does not already exist
#
# @param1 path of source file (the file to copy)
# @param2 path of destination file
# @return
#   - 0 when the destination file was copied
#   - 1 when the destination file already existed
##########\""
jr_funct_copy_file_idempotent(){
    local sourcePath="${1}"
    local destinationPath="${2}"
    
    if [ -f "${destinationPath}" ]; then
        return 1
    else
        cp "${sourcePath}" "${destinationPath}"
        return 0
    fi
}
export -f jr_funct_copy_file_idempotent