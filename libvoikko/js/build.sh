#!/bin/sh

emmake make
emcc -g0 -O3 src/.libs/libvoikko.so.1.14.3 --memory-init-file 0 --closure 1 --preload-file 5 -o js/libvoikko.js --post-js js/libvoikko_api.js -s MODULARIZE="1" -s EXPORT_NAME="'Libvoikko'" -s NO_EXIT_RUNTIME="1" -s EXPORTED_FUNCTIONS="['_voikkoInit','_voikkoTerminate','_voikkoSetBooleanOption','_voikkoSetIntegerOption','_voikkoSpellCstr','_voikkoSuggestCstr','_voikkoHyphenateCstr','_voikkoFreeCstrArray','_voikkoFreeCstr','_voikkoNextTokenCstr','_voikkoNextSentenceStartCstr','_voikkoNextGrammarErrorCstr','_voikkoGetGrammarErrorCode','_voikkoGetGrammarErrorStartPos','_voikkoGetGrammarErrorLength','_voikkoGetGrammarErrorSuggestions','_voikkoFreeGrammarError','_voikkoGetGrammarErrorShortDescription','_voikkoFreeErrorMessageCstr','_voikko_list_dicts','_voikko_free_dicts','_voikko_dict_language','_voikko_dict_script','_voikko_dict_variant','_voikko_dict_description','_voikkoGetVersion','_voikkoAnalyzeWordCstr','_voikko_free_mor_analysis','_voikko_mor_analysis_keys','_voikko_mor_analysis_value_cstr','_voikko_free_mor_analysis_value_cstr']"
cat js/libvoikko.js js/commonjs-footer.js > js/js-libvoikko.js