#!/usr/bin/env bash
##############################
# Exports:
# - jr_funct_translate
#   @see jr_doc_funct_translate
#
# Requires
# - jq
#   @see https://stedolan.github.io/jq/
##############################

alias jr_doc_funct_translate="echo \"
##########
# Translates text by using DeepL API
#
# @param1 target language. Must be one of:
#   - DE
#   - EN
#   - FR
#   - ES
#   - IT
#   - NL
#   - PL
# @param2 text to translate
# @stdout possible translations
##########\""
jr_funct_translate(){
    local targetLanguage="${1}"
    local textToTranslate="${2}"

    local request=$(jq -n --arg text "${textToTranslate}" --arg target "${targetLanguage}" '{
                      "jsonrpc": "2.0",
                      "method": "LMT_handle_jobs",
                      "params": {
                        "jobs": [
                          {
                            "kind": "default",
                            "raw_en_sentence": $text
                          }
                        ],
                        "lang": {
                          "source_lang_user_selected": "auto",
                          "target_lang": $target
                        }
                      }
                    }')
    
    curl --silent --data "${request}" https://www.deepl.com/jsonrpc \
       | jq --raw-output '"Detected language: \(.result.source_lang):", .result.translations[0].beams[].postprocessed_sentence'
}
export -f jr_funct_translate