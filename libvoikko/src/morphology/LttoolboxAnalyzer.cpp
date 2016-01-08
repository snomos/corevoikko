/* Libvoikko: Library of Finnish language tools
 * Copyright (C) 2010 Harri Pitkänen <hatapitk@iki.fi>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 *********************************************************************************/

#include "morphology/LttoolboxAnalyzer.hpp"
#include "setup/DictionaryException.hpp"
#include "utils/StringUtils.hpp"
#include "character/SimpleChar.hpp"
#include "voikko_defines.h"

using namespace libvoikko::utils;

namespace libvoikko { namespace morphology {

LttoolboxAnalyzer::LttoolboxAnalyzer(const string & directoryName) throw(setup::DictionaryException) {
	string fileName = directoryName + "/mor.bin";
	FILE * transducerFile = fopen(fileName.c_str(), "r");
	if (!transducerFile) {
		throw setup::DictionaryException("Failed to open mor.bin");
	}
	processor.load(transducerFile);
	fclose(transducerFile);
	processor.setCaseSensitiveMode(false);
	processor.initBiltrans();
}
    
list<Analysis *> * LttoolboxAnalyzer::analyze(const wchar_t * word) {
	return analyze(word, wcslen(word));
}

list<Analysis *> * LttoolboxAnalyzer::analyze(const wchar_t * word,
                                         size_t wlen) {
	if (wlen > LIBVOIKKO_MAX_WORD_CHARS) {
		return new list<Analysis *>();
	}
	wstring inputString = L"";
	// TODO: don't know how to do case insensitive analysis with Lttoolbox.
	// Working around by capitalizing the first letter as this allows
	// at least typical proper nouns to be handled correctly.
	inputString.append(1, character::SimpleChar::upper(word[0]));
	for (size_t i = 1; i < wlen; i++) {
		inputString.append(1, word[i]);
	}
	wstring analysisString = processor.biltransWithQueue(inputString, false).first;
	list<Analysis *> * result = new list<Analysis *>();
	
	if (analysisString[0] != L'@') {
		addAnalysis(analysisString, result, wlen);
	}
	return result;
}

list<Analysis *> * LttoolboxAnalyzer::analyze(const char * word) {
	size_t wlen = strlen(word);
	if (wlen > LIBVOIKKO_MAX_WORD_CHARS) {
		return new list<Analysis *>();
	}
	wchar_t * wordUcs4 = StringUtils::ucs4FromUtf8(word);
	list<Analysis *> * analysisList = analyze(wordUcs4);
	delete[] wordUcs4;
	return analysisList;
}

static void addSingleAnalysis(wstring analysisString, list<Analysis *> * analysisList, size_t charCount) {
	Analysis * analysis = new Analysis();
	bool isNp = false;
	if (analysisString.find(L"<np>") != wstring::npos) {
		isNp = true;
		analysis->addAttribute("CLASS", utils::StringUtils::copy(L"nimi"));
	} else if (analysisString.find(L"<adj>") != wstring::npos) {
		analysis->addAttribute("CLASS", utils::StringUtils::copy(L"LAATUSANA"));
	} else {
		// TODO other categories from http://wiki.apertium.org/wiki/List_of_symbols
		analysis->addAttribute("CLASS", utils::StringUtils::copy(L"LAATUSANA"));
	}
	wchar_t * structure = new wchar_t[charCount + 2];
	structure[0] = L'=';
	structure[1] = (isNp ? L'i' : L'p');
	for (size_t i = 2; i < charCount + 1; i++) {
		structure[i] = L'p';
	}
	structure[charCount + 1] = L'\0';
	analysis->addAttribute("STRUCTURE", structure);
	
	analysis->addAttribute("SIJAMUOTO", utils::StringUtils::copy(L"none"));
	analysisList->push_back(analysis);
}

void LttoolboxAnalyzer::addAnalysis(wstring analysisString, list<Analysis *> * analysisList, size_t charCount) const {
	if (analysisString.find(L"^@") == 0) {
		return;
	}
	size_t analysisStart = 1;
	for (size_t analysisEnd = analysisString.find(L"/");
			analysisEnd != wstring::npos;
			analysisEnd = analysisString.find(L"/", analysisStart)) {
		addSingleAnalysis(analysisString.substr(analysisStart, analysisEnd - analysisStart), analysisList, charCount);
		analysisStart = analysisEnd + 1;
	}
	addSingleAnalysis(analysisString.substr(analysisStart, analysisString.length() - analysisStart - 1), analysisList, charCount);
}

void LttoolboxAnalyzer::terminate() {
}

} }
