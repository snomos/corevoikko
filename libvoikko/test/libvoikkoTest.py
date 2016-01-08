# -*- coding: utf-8 -*-

# Copyright 2009 - 2011 Harri Pitkänen (hatapitk@iki.fi)
# Test suite for testing public API of libvoikko and the Python interface.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

import unittest
import re
from libvoikko import *
from TestUtils import MorphologyInfo, TestDataDir

class LibvoikkoTest(unittest.TestCase):
	def setUp(self):
		self.voikko = Voikko(u"fi")
	
	def tearDown(self):
		self.voikko.terminate()
	
	def testInitAndTerminate(self):
		pass # do nothing, just check that setUp and tearDown complete succesfully
	
	def testTerminateCanBeCalledMultipleTimes(self):
		self.voikko.terminate()
		self.voikko.terminate()
	
	def testAnotherObjectCanBeCreatedUsedAndDeletedInParallel(self):
		medicalVoikko = Voikko(u"fi-x-medicine")
		self.failUnless(medicalVoikko.spell(u"amifostiini"))
		self.failIf(self.voikko.spell(u"amifostiini"))
		del medicalVoikko
		self.failIf(self.voikko.spell(u"amifostiini"))
	
	def testDictionaryComparisonWorks(self):
		d1 = Dictionary(u"fi", u"", u"a", u"b")
		d2 = Dictionary(u"fi", u"", u"a", u"c")
		d3 = Dictionary(u"fi", u"", u"c", u"b")
		d4 = Dictionary(u"fi", u"", u"a", u"b")
		d5 = Dictionary(u"sv", u"", u"a", u"b")
		self.assertNotEqual(u"kissa", d1)
		self.assertNotEqual(d1, u"kissa")
		self.assertNotEqual(d1, d2)
		self.assertNotEqual(d1, d3)
		self.assertNotEqual(d4, d5)
		self.assertEqual(d1, d4)
		self.failUnless(d1 < d2)
		self.failUnless(d2 < d3)
		self.failUnless(d4 < d5)
	
	def testDictionaryHashCodeWorks(self):
		d1 = Dictionary(u"fi", u"", u"a", u"b")
		d2 = Dictionary(u"fi", u"", u"a", u"c")
		d3 = Dictionary(u"fi", u"", u"c", u"b")
		d4 = Dictionary(u"fi", u"", u"a", u"b")
		d5 = Dictionary(u"sv", u"", u"a", u"b")
		self.assertNotEqual(hash(d1), hash(d2))
		self.assertNotEqual(hash(d1), hash(d3))
		self.assertNotEqual(hash(d4), hash(d5))
		self.assertEqual(hash(d1), hash(d4))
	
	def testListDictsWithoutPath(self):
		dicts = Voikko.listDicts()
		self.failUnless(len(dicts) > 0)
		standard = dicts[0]
		self.assertEqual(u"standard", standard.variant,
		     u"Standard dictionary must be the default in test environment.")
	
	def testListSupportedSpellingLanguagesWithoutPath(self):
		langs = Voikko.listSupportedSpellingLanguages()
		self.failUnless(u"fi" in langs, u"Finnish dictionary must be present in the test environment")
	
	def testListDictsWithPathAndAttributes(self):
		info = MorphologyInfo()
		info.variant = u"test-variant-name"
		info.description = u"Some test description sakldjasd"
		info.morphology = u"null"
		dataDir = TestDataDir()
		dataDir.createMorphology(info.variant, info)
		dicts = Voikko.listDicts(dataDir.getDirectory())
		dataDir.tearDown()
		dictsWithCorrectVariant = list(filter(lambda aDict: aDict.variant == info.variant, dicts))
		self.assertEqual(1, len(dictsWithCorrectVariant))
		theDict = dictsWithCorrectVariant[0]
		self.assertEqual(info.description, theDict.description)
		self.assertEqual(u"fi", theDict.language)
		self.assertEqual(u"", theDict.script)
	
	def testInitWithCorrectDictWorks(self):
		self.voikko.terminate()
		self.voikko = Voikko(u"fi-x-standard")
		self.failIf(self.voikko.spell(u"amifostiini"))
		self.voikko.terminate()
		self.voikko = Voikko(u"fi-x-medicine")
		self.failUnless(self.voikko.spell(u"amifostiini"))
	
	def testInitWithNonExistentDictThrowsException(self):
		def tryInit():
			self.voikko = Voikko(u"fi-x-non-existent-variant")
		self.voikko.terminate()
		self.assertRaises(VoikkoException, tryInit)
	
	def testInitWithPathWorks(self):
		# TODO: better test
		self.voikko.terminate()
		self.voikko = Voikko(u"fi", path = u"/path/to/nowhere")
		self.failUnless(self.voikko.spell(u"kissa"))
	
	def testSpellAfterTerminateThrowsException(self):
		def trySpell():
			self.voikko.spell(u"kissa")
		self.voikko.terminate()
		self.assertRaises(VoikkoException, trySpell)
	
	def testSpell(self):
		self.failUnless(self.voikko.spell(u"määrä"))
		self.failIf(self.voikko.spell(u"määä"))
	
	def testSuggest(self):
		suggs = self.voikko.suggest(u"koirra")
		self.failUnless(u"koira" in suggs)
	
	def testSuggestReturnsArgumentIfWordIsCorrect(self):
		suggs = self.voikko.suggest(u"koira")
		self.assertEqual(1, len(suggs))
		self.assertEqual(u"koira", suggs[0])
	
	def testGrammarErrorsAndExplanation(self):
		errors = self.voikko.grammarErrors(u"Minä olen joten kuten kaunis.", "fi")
		self.assertEqual(1, len(errors))
		error = errors[0]
		self.assertEqual(10, error.startPos)
		self.assertEqual(11, error.errorLen)
		self.assertEqual([u"jotenkuten"], error.suggestions)
		self.assertEqual(u"Virheellinen kirjoitusasu", error.shortDescription)
	
	def testNoGrammarErrorsInEmptyParagraph(self):
		errors = self.voikko.grammarErrors(u"Olen täi.\n\nOlen täi.", "fi")
		self.assertEqual(0, len(errors))
	
	def testGrammarErrorOffsetsInMultipleParagraphs(self):
		errors = self.voikko.grammarErrors(u"Olen täi.\n\nOlen joten kuten.", "fi")
		self.assertEqual(1, len(errors))
		error = errors[0]
		self.assertEqual(16, error.startPos)
		self.assertEqual(11, error.errorLen)
	
	def testAnalyze(self):
		analysisList = self.voikko.analyze(u"kansaneläkehakemus")
		self.assertEqual(1, len(analysisList))
		analysis = analysisList[0]
		self.assertEqual(u"=pppppp=ppppp=ppppppp", analysis["STRUCTURE"])
	
	def testTokens(self):
		tokenList = self.voikko.tokens(u"kissa ja koira")
		self.assertEqual(5, len(tokenList))
		tokenJa = tokenList[2]
		self.assertEqual(Token.WORD, tokenJa.tokenType)
		self.assertEqual(u"ja", tokenJa.tokenText)
	
	def testSentences(self):
		sentences = self.voikko.sentences(u"Kissa ei ole koira. Koira ei ole kissa.")
		self.assertEqual(2, len(sentences))
		self.assertEqual(u"Kissa ei ole koira. ", sentences[0].sentenceText)
		self.assertEqual(Sentence.PROBABLE, sentences[0].nextStartType)
		self.assertEqual(u"Koira ei ole kissa.", sentences[1].sentenceText)
		self.assertEqual(Sentence.NONE, sentences[1].nextStartType)
	
	def testHyphenationPattern(self):
		pattern = self.voikko.getHyphenationPattern(u"kissa")
		self.assertEqual("   - ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"määrä")
		self.assertEqual("   - ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"kuorma-auto")
		self.assertEqual("    - =  - ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"vaa'an")
		self.assertEqual("   =  ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"auton-")
		self.assertEqual("  -   ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"aztoa-")
		self.assertEqual("  - - ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"aztoa-alus")
		self.assertEqual("  - -= -  ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"-auton")
		self.assertEqual("   -  ", pattern)
		pattern = self.voikko.getHyphenationPattern(u"-aztoa")
		self.assertEqual("   - -", pattern)
	
	def testHyphenate(self):
		self.assertEqual(u"kis-sa", self.voikko.hyphenate(u"kissa"))
		self.assertEqual(u"mää-rä", self.voikko.hyphenate(u"määrä"))
		self.assertEqual(u"kuor-ma-au-to", self.voikko.hyphenate(u"kuorma-auto"))
		self.assertEqual(u"vaa-an", self.voikko.hyphenate(u"vaa'an"))
	
	def testSetIgnoreDot(self):
		self.voikko.setIgnoreDot(False)
		self.failIf(self.voikko.spell(u"kissa."))
		self.voikko.setIgnoreDot(True)
		self.failUnless(self.voikko.spell(u"kissa."))
	
	def testSetBooleanOption(self):
		self.voikko.setBooleanOption(0, False) # This is "ignore dot"
		self.failIf(self.voikko.spell(u"kissa."))
		self.voikko.setBooleanOption(0, True)
		self.failUnless(self.voikko.spell(u"kissa."))
	
	def testSetIgnoreNumbers(self):
		self.voikko.setIgnoreNumbers(False)
		self.failIf(self.voikko.spell(u"kissa2"))
		self.voikko.setIgnoreNumbers(True)
		self.failUnless(self.voikko.spell(u"kissa2"))
	
	def testSetIgnoreUppercase(self):
		self.voikko.setIgnoreUppercase(False)
		self.failIf(self.voikko.spell(u"KAAAA"))
		self.voikko.setIgnoreUppercase(True)
		self.failUnless(self.voikko.spell(u"KAAAA"))
	
	def testAcceptFirstUppercase(self):
		self.voikko.setAcceptFirstUppercase(False)
		self.failIf(self.voikko.spell("Kissa"))
		self.voikko.setAcceptFirstUppercase(True)
		self.failUnless(self.voikko.spell("Kissa"))
	
	def testUpperCaseScandinavianLetters(self):
		self.failUnless(self.voikko.spell(u"Äiti"))
		self.failIf(self.voikko.spell(u"Ääiti"))
		self.failUnless(self.voikko.spell(u"š"))
		self.failUnless(self.voikko.spell(u"Š"))
	
	def testAcceptAllUppercase(self):
		self.voikko.setIgnoreUppercase(False)
		self.voikko.setAcceptAllUppercase(False)
		self.failIf(self.voikko.spell("KISSA"))
		self.voikko.setAcceptAllUppercase(True)
		self.failUnless(self.voikko.spell("KISSA"))
		self.failIf(self.voikko.spell("KAAAA"))
	
	def testIgnoreNonwords(self):
		self.voikko.setIgnoreNonwords(False)
		self.failIf(self.voikko.spell("hatapitk@iki.fi"))
		self.voikko.setIgnoreNonwords(True)
		self.failUnless(self.voikko.spell("hatapitk@iki.fi"))
		self.failIf(self.voikko.spell("ashdaksd"))
	
	def testAcceptExtraHyphens(self):
		self.voikko.setAcceptExtraHyphens(False)
		self.failIf(self.voikko.spell("kerros-talo"))
		self.voikko.setAcceptExtraHyphens(True)
		self.failUnless(self.voikko.spell("kerros-talo"))
	
	def testAcceptMissingHyphens(self):
		self.voikko.setAcceptMissingHyphens(False)
		self.failIf(self.voikko.spell("sosiaali"))
		self.voikko.setAcceptMissingHyphens(True)
		self.failUnless(self.voikko.spell("sosiaali"))
	
	def testSetAcceptTitlesInGc(self):
		self.voikko.setAcceptTitlesInGc(False)
		self.assertEqual(1, len(self.voikko.grammarErrors(u"Kissa on eläin", "fi")))
		self.voikko.setAcceptTitlesInGc(True)
		self.assertEqual(0, len(self.voikko.grammarErrors(u"Kissa on eläin", "fi")))
	
	def testSetAcceptUnfinishedParagraphsInGc(self):
		self.voikko.setAcceptUnfinishedParagraphsInGc(False)
		self.assertEqual(1, len(self.voikko.grammarErrors(u"Kissa on ", "fi")))
		self.voikko.setAcceptUnfinishedParagraphsInGc(True)
		self.assertEqual(0, len(self.voikko.grammarErrors(u"Kissa on ", "fi")))
	
	def testSetAcceptBulletedListsInGc(self):
		self.voikko.setAcceptBulletedListsInGc(False)
		self.assertNotEqual(0, len(self.voikko.grammarErrors(u"kissa", "fi")))
		self.voikko.setAcceptBulletedListsInGc(True)
		self.assertEqual(0, len(self.voikko.grammarErrors(u"kissa", "fi")))
	
	def testSetNoUglyHyphenation(self):
		self.voikko.setNoUglyHyphenation(False)
		self.assertEqual(u"i-va", self.voikko.hyphenate(u"iva"))
		self.voikko.setNoUglyHyphenation(True)
		self.assertEqual(u"iva", self.voikko.hyphenate(u"iva"))
	
	def testSetHyphenateUnknownWordsWorks(self):
		self.voikko.setHyphenateUnknownWords(False)
		self.assertEqual(u"kirjutepo", self.voikko.hyphenate(u"kirjutepo"))
		self.voikko.setHyphenateUnknownWords(True)
		self.assertEqual(u"kir-ju-te-po", self.voikko.hyphenate(u"kirjutepo"))
	
	def testSetMinHyphenatedWordLength(self):
		self.voikko.setMinHyphenatedWordLength(6)
		self.assertEqual(u"koira", self.voikko.hyphenate(u"koira"))
		self.voikko.setMinHyphenatedWordLength(2)
		self.assertEqual(u"koi-ra", self.voikko.hyphenate(u"koira"))
	
	def testIncreaseSpellerCacheSize(self):
		# TODO: this only tests that nothing breaks, not that cache is actually increased
		self.voikko.setSpellerCacheSize(3)
		self.failUnless(self.voikko.spell(u"kissa"))
	
	def testDisableSpellerCache(self):
		# TODO: this only tests that nothing breaks, not that cache is actually disabled
		self.voikko.setSpellerCacheSize(-1)
		self.failUnless(self.voikko.spell(u"kissa"))
	
	def testSetSuggestionStrategy(self):
		self.voikko.setSuggestionStrategy(SuggestionStrategy.OCR)
		self.failIf(u"koira" in self.voikko.suggest(u"koari"))
		self.failUnless(u"koira" in self.voikko.suggest(u"koir_"))
		self.voikko.setSuggestionStrategy(SuggestionStrategy.TYPO)
		self.failUnless(u"koira" in self.voikko.suggest(u"koari"))
	
	def testMaxAnalysisCountIsNotPassed(self):
		complexWord = u"lumenerolumenerolumenerolumenerolumenero"
		self.failUnless(len(self.voikko.analyze(complexWord)) <= MAX_ANALYSIS_COUNT)
	
	def testMorPruningWorks(self):
		# TODO: this test will not fail, it just takes very long time
		# if pruning does not work.
		complexWord = u""
		for i in range(0, 20):
			complexWord = complexWord + u"lumenero"
		self.failUnless(len(complexWord) < MAX_WORD_CHARS)
		self.voikko.analyze(complexWord)
	
	def testOverLongWordsAreRejectedInSpellCheck(self):
		# Limit is 255 characters. This behavior is deprecated and may change.
		longWord = u""
		for i in range(0, 25):
			longWord = longWord + u"kuraattori"
		self.failUnless(len(longWord) < MAX_WORD_CHARS)
		self.failUnless(self.voikko.spell(longWord))
		
		longWord = longWord + u"kuraattori"
		self.failUnless(len(longWord) > MAX_WORD_CHARS)
		self.failIf(self.voikko.spell(longWord))
	
	def testOverLongWordsAreRejectedInAnalysis(self):
		# Limit is 255 characters. This behavior is deprecated and may change.
		longWord = u""
		for i in range(0, 25):
			longWord = longWord + u"kuraattori"
		self.failUnless(len(longWord) < MAX_WORD_CHARS)
		self.assertEqual(1, len(self.voikko.analyze(longWord)))
		
		longWord = longWord + u"kuraattori"
		self.failUnless(len(longWord) > MAX_WORD_CHARS)
		self.assertEqual(0, len(self.voikko.analyze(longWord)))
	
	def testEmbeddedNullsAreNotAccepted(self):
		self.failIf(self.voikko.spell(u"kissa\0asdasd"))
		self.assertEqual(0, len(self.voikko.suggest(u"kisssa\0koira")))
		self.assertEqual(u"kissa\0koira", self.voikko.hyphenate(u"kissa\0koira"))
		self.assertEquals(0, len(self.voikko.grammarErrors(u"kissa\0koira", "fi")))
		self.assertEquals(0, len(self.voikko.analyze(u"kissa\0koira")))
	
	def testNullCharMeansSingleSentence(self):
		sentences = self.voikko.sentences(u"kissa\0koira. Koira ja kissa.")
		self.assertEqual(1, len(sentences))
		self.assertEqual(Sentence.NONE, sentences[0].nextStartType)
		self.assertEqual(u"kissa\0koira. Koira ja kissa.", sentences[0].sentenceText)
	
	def testNullCharIsUnknownToken(self):
		tokens = self.voikko.tokens(u"kissa\0koira")
		self.assertEquals(3, len(tokens))
		self.assertEquals(Token.WORD, tokens[0].tokenType)
		self.assertEquals(u"kissa", tokens[0].tokenText)
		self.assertEquals(Token.UNKNOWN, tokens[1].tokenType)
		self.assertEquals(u"\0", tokens[1].tokenText)
		self.assertEquals(Token.WORD, tokens[2].tokenType)
		self.assertEquals(u"koira", tokens[2].tokenText)
		
		tokens = self.voikko.tokens(u"kissa\0\0koira")
		self.assertEquals(4, len(tokens))
		self.assertEquals(Token.WORD, tokens[0].tokenType)
		self.assertEquals(u"kissa", tokens[0].tokenText)
		self.assertEquals(Token.UNKNOWN, tokens[1].tokenType)
		self.assertEquals(u"\0", tokens[1].tokenText)
		self.assertEquals(Token.UNKNOWN, tokens[2].tokenType)
		self.assertEquals(u"\0", tokens[2].tokenText)
		self.assertEquals(Token.WORD, tokens[3].tokenType)
		self.assertEquals(u"koira", tokens[3].tokenText)
		
		tokens = self.voikko.tokens(u"kissa\0")
		self.assertEquals(2, len(tokens))
		self.assertEquals(Token.WORD, tokens[0].tokenType)
		self.assertEquals(u"kissa", tokens[0].tokenText)
		self.assertEquals(Token.UNKNOWN, tokens[1].tokenType)
		self.assertEquals(u"\0", tokens[1].tokenText)
		
		tokens = self.voikko.tokens(u"\0kissa")
		self.assertEquals(2, len(tokens))
		self.assertEquals(Token.UNKNOWN, tokens[0].tokenType)
		self.assertEquals(u"\0", tokens[0].tokenText)
		self.assertEquals(Token.WORD, tokens[1].tokenType)
		self.assertEquals(u"kissa", tokens[1].tokenText)
		
		tokens = self.voikko.tokens(u"\0")
		self.assertEquals(1, len(tokens))
		self.assertEquals(Token.UNKNOWN, tokens[0].tokenType)
		self.assertEquals(u"\0", tokens[0].tokenText)
		
		self.assertEquals(0, len(self.voikko.tokens(u"")))
	
	def testAllCapsAndDot(self):
		self.voikko.setIgnoreDot(True)
		self.failIf(self.voikko.spell(u"ABC-DEF."))
	
	def testGetVersion(self):
		version = Voikko.getVersion()
		# We can't test for correct version but let's assume it starts with a number
		self.failUnless(re.compile(u"[0-9].*").match(version) != None)

if __name__ == "__main__":
	suite = unittest.TestLoader().loadTestsFromTestCase(LibvoikkoTest)
	unittest.TextTestRunner(verbosity=1).run(suite)
