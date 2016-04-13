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
 * Portions created by the Initial Developer are Copyright (C) 2012
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

#ifndef VOIKKO_MORPHOLOGY_FINNISH_VFST_ANALYZER
#define VOIKKO_MORPHOLOGY_FINNISH_VFST_ANALYZER

#include "morphology/Analyzer.hpp"
#include "setup/DictionaryException.hpp"
#include "fst/UnweightedTransducer.hpp"
#include "fst/Configuration.hpp"
#include <list>
#include <string>

namespace libvoikko { namespace morphology {

/**
 * Morphological analyzer that uses the built in FST implementation to analyze Finnish words.
 */
class FinnishVfstAnalyzer : public Analyzer {
	public:
		FinnishVfstAnalyzer(const std::string & directoryName) throw(setup::DictionaryException);
		std::list<Analysis *> * analyze(const wchar_t * word, size_t wlen, bool fullMorphology);
		std::list<Analysis *> * analyze(const char * word, bool fullMorphology);
		void terminate();
	private:
		fst::UnweightedTransducer * transducer;
		fst::Configuration * configuration;
		wchar_t * outputBuffer;
		std::map<std::wstring, const wchar_t *> classMap;
		std::map<std::wstring, const wchar_t *> sijamuotoMap;
		std::map<std::wstring, const wchar_t *> moodMap;
		std::map<std::wstring, const wchar_t *> numberMap;
		std::map<std::wstring, const wchar_t *> comparisonMap;
		std::map<std::wstring, const wchar_t *> personMap;
		std::map<std::wstring, const wchar_t *> tenseMap;
		std::map<std::wstring, const wchar_t *> focusMap;
		std::map<std::wstring, const wchar_t *> possessiveMap;
		std::map<std::wstring, const wchar_t *> negativeMap;
		std::map<std::wstring, const wchar_t *> participleMap;
		
		void parseBasicAttributes(Analysis * analysis, const wchar_t * fstOutput, size_t fstLen);
		void parseDebugAttributes(Analysis * analysis, const wchar_t * fstOutput, size_t fstLen);
		void duplicateOrgName(Analysis * analysis, const wchar_t * fstOutput, std::list<Analysis *> * analysisList);
};

} }

#endif
