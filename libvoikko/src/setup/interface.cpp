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
 * Portions created by the Initial Developer are Copyright (C) 2009
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

#include <cstring>
#include <set>
#include "setup/Dictionary.hpp"
#include "setup/DictionaryFactory.hpp"
#include "porting.h"

using namespace std;

namespace libvoikko { namespace setup {

typedef Dictionary voikko_dict;

static const int CAPABILITY_SPELL = 1;
static const int CAPABILITY_GC = 2;
static const int CAPABILITY_HYPHENATION = 4;

VOIKKOEXPORT voikko_dict ** voikko_list_dicts(const char * path) {
	list<Dictionary> dictList = path ?
	                            DictionaryFactory::findAllAvailable(path) :
	                            DictionaryFactory::findAllAvailable();
	
	voikko_dict ** dicts = new voikko_dict*[dictList.size() + 1];
	size_t n = 0;
	for (list<Dictionary>::iterator i = dictList.begin(); i != dictList.end(); ++i) {
		dicts[n++] = new Dictionary(*i);
	}
	dicts[n] = 0;
	return dicts;
}

VOIKKOEXPORT void voikko_free_dicts(voikko_dict ** dicts) {
	for (voikko_dict ** i = dicts; *i; i++) {
		delete *i;
	}
	delete[] dicts;
}

VOIKKOEXPORT const char * voikko_dict_language(const voikko_dict * dict) {
	return dict->getLanguage().getLanguage().c_str();
}

VOIKKOEXPORT const char * voikko_dict_script(const voikko_dict * dict) {
	return dict->getLanguage().getScript().c_str();
}

VOIKKOEXPORT const char * voikko_dict_variant(const voikko_dict * dict) {
	const char * variant = dict->getLanguage().getPrivateUse().c_str();
	if (variant && variant[0] != '\0') {
		return variant;
	}
	return "standard";
}

VOIKKOEXPORT const char * voikko_dict_description(const voikko_dict * dict) {
	return dict->getDescription().c_str();
}

static string getShortLangForCapabilityFilteredList(LanguageTag langTag) {
	if (langTag.getScript() == "") {
		return langTag.getLanguage();
	}
	// TODO script should not be appended  if it is not strictly needed,
	// For now we just trust the dictionary maintainers to do the right thing.
	return langTag.getLanguage() + "-" + langTag.getScript();
}

// TODO: implement filtering by capability
static char ** listSupportedLanguagesForCapability(const char * path, int capability) {
	list<Dictionary> dictList = path ?
	                            DictionaryFactory::findAllAvailable(path) :
	                            DictionaryFactory::findAllAvailable();
	set<string> allLanguages;
	for (list<Dictionary>::iterator i = dictList.begin(); i != dictList.end(); ++i) {
		Dictionary d = *i;
		if ((capability == CAPABILITY_SPELL && d.getSpellBackend().isAdvertised()) ||
		    (capability == CAPABILITY_HYPHENATION && d.getHyphenatorBackend().isAdvertised()) ||
		    (capability == CAPABILITY_GC && d.getGrammarBackend().isAdvertised())) {
			allLanguages.insert(getShortLangForCapabilityFilteredList(d.getLanguage()));
		}
	}
	
	char ** languages = new char*[allLanguages.size() + 1];
	size_t n = 0;
	for (set<string>::iterator i = allLanguages.begin(); i != allLanguages.end(); ++i) {
		string lang = *i;
		languages[n] = new char[lang.size() + 1];
		strcpy(languages[n], lang.c_str());
		n++;
	}
	languages[n] = 0;
	return languages;
}

VOIKKOEXPORT char ** voikkoListSupportedSpellingLanguages(const char * path) {
	return listSupportedLanguagesForCapability(path, CAPABILITY_SPELL);
}

VOIKKOEXPORT char ** voikkoListSupportedHyphenationLanguages(const char * path) {
	return listSupportedLanguagesForCapability(path, CAPABILITY_HYPHENATION);
}

VOIKKOEXPORT char ** voikkoListSupportedGrammarCheckingLanguages(const char * path) {
	return listSupportedLanguagesForCapability(path, CAPABILITY_GC);
}

VOIKKOEXPORT const char * voikkoGetVersion() {
	#ifdef PACKAGE_VERSION
		return PACKAGE_VERSION;
	#else
		return "(unknown)";
	#endif
}

} }
