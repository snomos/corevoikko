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


#ifndef LIBVOIKKO_FST_TRANSDUCER_H
#define LIBVOIKKO_FST_TRANSDUCER_H

#include <cstddef>
#include <map>
#include <vector>
#include <string>
#include <stdint.h>

namespace libvoikko { namespace fst {
	
	enum Operation {
		Operation_P,
		Operation_C,
		Operation_U,
		Operation_R,
		Operation_D
	};
	
	struct OpFeatureValue {
		Operation op;
		uint16_t feature;
		uint16_t value;
	};
	
	const uint16_t FlagValueNeutral = 0;
	const uint16_t FlagValueAny = 1;
	const uint32_t MAX_LOOP_COUNT = 100000;
	
	class Transducer {
		protected:
			size_t fileLength;
			void * map;
			bool byteSwapped;
			
			OpFeatureValue getDiacriticOperation(const std::string & symbol, std::map<std::string, uint16_t> & features, std::map<std::string, uint16_t> & values);
			void * vfstMmap(const char * filePath, size_t & fileLength);
			void vfstMunmap(void * map, size_t fileLength);
			bool checkNeedForByteSwapping(const char * filePtr);
			bool isWeightedTransducerFile(const char * filePtr);
		public:
			uint16_t flagDiacriticFeatureCount;
			uint16_t firstNormalChar;
			std::vector<OpFeatureValue> symbolToDiacritic;
			
			uint16_t getFlagDiacriticFeatureCount() const;
			
			void terminate();
			
			virtual ~Transducer();
	};
} }

#endif
