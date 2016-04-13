/* The contents of this file are subject to the Mozilla Public License Version 
 * 1.1 (the "License"); you may not use this file except in compliance with 
 * the License. You may obtain a copy of the License at 
 * http://www.mozilla.org/MPL/
 * 
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 * 
 * The Original Code is Libvoikko: Library of natural language processing tools.
 * The Initial Developer of the Original Code is Harri Pitkänen <hatapitk@iki.fi>.
 * Portions created by the Initial Developer are Copyright (C) 2006 - 2010
 * the Initial Developer. All Rights Reserved.
 * 
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *********************************************************************************/

#include "porting.h"
#include "setup/setup.hpp"
#include "utils/utils.hpp"
#include "utils/StringUtils.hpp"
#include "character/charset.hpp"
#include "character/SimpleChar.hpp"
#include "spellchecker/suggestion/SuggestionStatus.hpp"
#include "spellchecker/suggestion/SuggestionGenerator.hpp"
#include <cstring>
#include <cwchar>

#define MAX_SUGGESTIONS 5

using namespace libvoikko::spellchecker::suggestion;

namespace libvoikko {

wchar_t ** getSuggestions(SuggestionStatus & status, bool addDot) {
	const Suggestion * const originalSuggestions = status.getSuggestions();
	size_t returnedSuggestionCount = MAX_SUGGESTIONS < status.getSuggestionCount() ?
	                                 MAX_SUGGESTIONS : status.getSuggestionCount();
	wchar_t ** suggestions = new wchar_t*[returnedSuggestionCount + 1];
	for (size_t i = 0; i < returnedSuggestionCount; i++) {
		size_t sugglen = wcslen(originalSuggestions[i].word);
		bool doAddDot = (addDot && originalSuggestions[i].word[sugglen - 1] != L'.');
		wchar_t * buffer = new wchar_t[sugglen + 1 + (doAddDot ? 1 : 0)];
		wcsncpy(buffer, originalSuggestions[i].word, sugglen);
		if (doAddDot) {
			buffer[sugglen] = L'.';
			buffer[sugglen+1] = L'\0';
		}
		else {
			buffer[sugglen] = L'\0';
		}
		suggestions[i] = buffer;
	}
	suggestions[returnedSuggestionCount] = 0;
	return suggestions;
}

VOIKKOEXPORT void voikko_free_suggest_ucs4(wchar_t ** suggest_result) {
	if (suggest_result) {
		for (wchar_t ** p = suggest_result; *p; p++) {
			delete[] *p;
		}
		delete[] suggest_result;
	}
}

VOIKKOEXPORT void voikkoFreeCstrArray(char ** suggest_result) {
	if (suggest_result) {
		for (char ** p = suggest_result; *p; p++) {
			delete[] *p;
		}
		delete[] suggest_result;
	}
}

VOIKKOEXPORT wchar_t ** voikkoSuggestUcs4(voikko_options_t * options, const wchar_t * word) {
	bool add_dots = false;
	if (word == 0) return 0;
	size_t wlen = wcslen(word);
	if (wlen <= 1 || wlen > LIBVOIKKO_MAX_WORD_CHARS) return 0;
	
	wchar_t * nword = voikko_normalise(word, wlen);
	if (nword == 0) {
		return 0;
	}
	wlen = wcslen(nword);
	
	if (options->ignore_dot) {
		if (wlen == 2) {
			delete[] nword;
			return 0;
		}
		if (nword[wlen-1] == L'.') {
			nword[--wlen] = L'\0';
			add_dots = true;
		}
	}
	
	SuggestionStatus status(nword, wlen, MAX_SUGGESTIONS * 3);
	
	SuggestionGenerator * generator = options->suggestionGenerator;
	generator->generate(&status);
	
	if (status.getSuggestionCount() == 0) {
		delete[] nword;
		return 0;
	}
	
	status.sortSuggestions();

	wchar_t ** suggestions = getSuggestions(status, add_dots);

	/* Change the character case to match the original word */
	enum casetype origcase = voikko_casetype(nword, wlen);
	size_t suglen;
	if (origcase == CT_FIRST_UPPER ||
	    (origcase == CT_COMPLEX && character::SimpleChar::isUpper(nword[0]))) {
		size_t i = 0;
		while (suggestions[i] != 0) {
			suglen = wcslen(suggestions[i]);
			if (voikko_casetype(suggestions[i], suglen) == CT_ALL_LOWER)
				voikko_set_case(CT_FIRST_UPPER, suggestions[i], suglen);
			i++;
		}
	}
	if (origcase == CT_ALL_UPPER && options->accept_all_uppercase) {
		size_t i = 0;
		while (suggestions[i] != 0) {
			suglen = wcslen(suggestions[i]);
			voikko_set_case(CT_ALL_UPPER, suggestions[i], suglen);
			i++;
		}
	}

	/* Undo character set normalisation */
	for (size_t i = 0; suggestions[i] != 0;) {
		suglen = wcslen(suggestions[i]);
		voikko_cset_reformat(word, wlen, &(suggestions[i]), suglen);
		i++;
	}

	delete[] nword;
	return suggestions;
}

VOIKKOEXPORT char ** voikkoSuggestCstr(voikko_options_t * options, const char * word) {
	if (word == 0 || word[0] == '\0') {
		return 0;
	}
	size_t len = strlen(word);
	if (len > LIBVOIKKO_MAX_WORD_CHARS) {
		return 0;
	}
	wchar_t * word_ucs4 = utils::StringUtils::ucs4FromUtf8(word, len);
	if (word_ucs4 == 0) {
		return 0;
	}
	wchar_t ** suggestions_ucs4 = voikkoSuggestUcs4(options, word_ucs4);
	delete[] word_ucs4;
	if (suggestions_ucs4 == 0) {
		return 0;
	}
	int scount = 0;
	while (suggestions_ucs4[scount] != 0) {
		scount++;
	}
	
	char ** suggestions = new char*[scount + 1];
	if (suggestions == 0) {
		voikko_free_suggest_ucs4(suggestions_ucs4);
		return 0;
	}
	
	int j = 0;
	for (int i = 0; i < scount; i++) {
		char * suggestion = utils::StringUtils::utf8FromUcs4(suggestions_ucs4[i]);
		if (suggestion == 0) {
			continue; /* suggestion cannot be encoded */
		}
		suggestions[j++] = suggestion;
	}
	voikko_free_suggest_ucs4(suggestions_ucs4);
	if (j == 0) {
		delete[] suggestions;
		return 0;
	}
	for (; j <= scount; j++) {
		suggestions[j] = 0;
	}
	
	return suggestions;
}

}
