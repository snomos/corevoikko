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

#include "setup/setup.hpp"

#include "grammar/FinnishRuleEngine.hpp"
#include "grammar/FinnishRuleEngine/checks.hpp"

#include "grammar/FinnishRuleEngine/MissingVerbCheck.hpp"
#include "grammar/FinnishRuleEngine/NegativeVerbCheck.hpp"
#include "grammar/FinnishRuleEngine/CompoundVerbCheck.hpp"
#include "grammar/FinnishRuleEngine/SidesanaCheck.hpp"

#ifdef HAVE_MALAGA
        #include "autocorrect/AutoCorrect.hpp"
#endif
#ifdef HAVE_VFST
        #include "grammar/FinnishRuleEngine/VfstAutocorrectCheck.hpp"
#endif


namespace libvoikko { namespace grammar {

FinnishRuleEngine::FinnishRuleEngine(voikko_options_t * voikkoOptions) :
	 voikkoOptions(voikkoOptions) {
	sentenceChecks.push_back(new check::MissingVerbCheck());
	sentenceChecks.push_back(new check::NegativeVerbCheck());
	sentenceChecks.push_back(new check::CompoundVerbCheck());
	sentenceChecks.push_back(new check::SidesanaCheck());
#ifdef HAVE_VFST
	if (voikkoOptions->dictionary.getGrammarBackend().getBackend() == "finnishVfst") {
		std::string autocorrFile = voikkoOptions->dictionary.getGrammarBackend().getPath() + "/autocorr.vfst";
		sentenceChecks.push_back(new check::VfstAutocorrectCheck(autocorrFile));
	}
#endif
}

FinnishRuleEngine::~FinnishRuleEngine() {
	std::list<check::SentenceCheck *>::iterator i = sentenceChecks.begin();
	for (; i != sentenceChecks.end(); ++i) {
		delete *i;
	}
}

void FinnishRuleEngine::check(const Paragraph * paragraph) {
	std::list<check::SentenceCheck *>::const_iterator sentenceCheckIt;
	for (size_t i = 0; i < paragraph->sentenceCount; i++) {
#ifdef HAVE_MALAGA
		if (voikkoOptions->dictionary.getGrammarBackend().getBackend() == "finnish") {
			libvoikko::autocorrect::AutoCorrect::autoCorrect(voikkoOptions, paragraph->sentences[i]);
		}
#endif
		gc_local_punctuation(voikkoOptions, paragraph->sentences[i]);
		gc_punctuation_of_quotations(voikkoOptions, paragraph->sentences[i]);
		gc_repeating_words(voikkoOptions, paragraph->sentences[i]);
		sentenceCheckIt = sentenceChecks.begin();
		for (; sentenceCheckIt != sentenceChecks.end(); ++sentenceCheckIt) {
			(*sentenceCheckIt)->check(voikkoOptions, paragraph->sentences[i]);
		}

	}


	capitalizationCheck.check(voikkoOptions, paragraph);
	gc_end_punctuation(voikkoOptions, paragraph);

}


} }
