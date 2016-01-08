/* Copyright (C) 1997 Bjoern Beutel.
 *               2009 Harri Pitkänen <hatapitk@iki.fi>
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

/* Description. =============================================================*/

/* Options for malaga and functions to start and terminate malaga. */

/* Includes. ================================================================*/

#include <cstdio>
#include <cstring>
#include <cstdlib>
#include "morphology/malaga/basic.hpp"
#include "morphology/malaga/pools.hpp"
#include "morphology/malaga/values.hpp"
#include "morphology/malaga/rule_type.hpp"
#include "morphology/malaga/rules.hpp"
#include "morphology/malaga/files.hpp"
#include "morphology/malaga/analysis.hpp"
#include "morphology/malaga/symbols.hpp"
#include "morphology/malaga/lexicon.hpp"
#include "morphology/malaga/patterns.hpp"
#include "morphology/malaga/malaga_lib.hpp"
#include "morphology/malaga/MalagaState.hpp"

namespace libvoikko { namespace morphology { namespace malaga {

/* Variables. ===============================================================*/

static const std::string morphology_file("voikko-fi_FI.mor");
static const std::string lexicon_file("voikko-fi_FI.lex");
static const std::string symbol_file("voikko-fi_FI.sym");

/* Functions. ===============================================================*/

static const char * pathSeparator() {
#ifdef WIN32
  return "\\";
#else
  return "/";
#endif
}

/*---------------------------------------------------------------------------*/

static const char *
binarySuffix() {
  union { char_t chars[4]; int_t integer; } format;

  format.integer = 0x12345678;
  if (sizeof( int_t ) != 4) {
    return "_c";
  }
  else if (format.chars[0] == 0x12 && format.chars[1] == 0x34
	   && format.chars[2] == 0x56 && format.chars[3] == 0x78) {
    return "_b";
  }
  else if (format.chars[0] == 0x78 && format.chars[1] == 0x56
	   && format.chars[2] == 0x34 && format.chars[3] == 0x12) {
     return "_l";
  }
  else {
    return "_c";
  }
}

/*---------------------------------------------------------------------------*/

void 
init_malaga(std::string directoryName, MalagaState * malagaState)
/* Initialise this module. */
{ 
  /* Init modules. */
  std::string fullSymbolFile = directoryName + pathSeparator() + symbol_file + binarySuffix();
  std::string fullLexiconFile = directoryName + pathSeparator() + lexicon_file + binarySuffix();
  std::string fullMorphologyFile = directoryName + pathSeparator() + morphology_file + binarySuffix();
  
  init_values(malagaState);
  init_symbols(fullSymbolFile.c_str(), malagaState);
  init_lexicon(fullLexiconFile.c_str(), malagaState);
  init_analysis(fullMorphologyFile.c_str(), malagaState);
}

/*---------------------------------------------------------------------------*/

void 
terminate_malaga(MalagaState * malagaState)
/* Terminate this module. */
{
  terminate_analysis(malagaState);
  terminate_patterns(malagaState);
  terminate_lexicon(malagaState);
  terminate_symbols(malagaState);
  terminate_values(malagaState);
}

}}}
