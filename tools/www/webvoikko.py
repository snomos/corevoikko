# -*- coding: utf-8 -*-

# Copyright 2007 - 2010 Harri Pitkänen (hatapitk@iki.fi)
# Web interface for Finnish linguistic tools based on Voikko

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

from mod_python import apache
from tempfile import mkstemp

import sys
import os
import subprocess
import urllib
import xml.sax.saxutils

# Hyphenator and spell checker commands
HYPHCOMMAND = 'LC_CTYPE="fi_FI.UTF-8" voikkohyphenate ignore_dot=1 '
POFILTERCOMMAND = 'pofilter'

# Maximum input length for hyphenator interface (in bytes)
MAX_INPUT_LENGTH = 20000

# Maximum file size for po file checking (in kbytes)
MAX_PO_SIZE = 1800

# Suomi-malaga project directory for pofilter
POFILTER_DICT_DIR = '/home/harri/po-oikoluku/voikko-fi/voikko'

# Colors for background-based hyphenator
HYPH_COLORS = ['#ffaaaa', '#aaaaff']

# Line length for output text
LINE_LENGTH = 80

def _write(req, text):
	"""Write to http response using output encoding"""
	req.write(text.encode('UTF-8'))

def _decode_form_value(string):
	"""Decodes a string from html form to unicode"""
	return _decode_if_valid(urllib.unquote_plus(string))

def _decode_if_valid(string):
	"""Decodes an UTF-8 string to unicode, returning empty string if decoding fails"""
	try:
		return unicode(string, 'UTF-8')
	except UnicodeDecodeError:
		return ""

def _escape_html(string):
	"""Converts a string to a form that is suitable for use in html document text"""
	return xml.sax.saxutils.escape(string)

def _hyphenate_wordlist(wordlist, options):
	"""Hyphenates a list of words with given voikkohyphenate command line opitions.
	Returns a list of hyphenated words."""
	hyphenator = subprocess.Popen(HYPHCOMMAND + options, shell = True, stdin = subprocess.PIPE,
	                              stdout = subprocess.PIPE, close_fds = True)
	for word in wordlist:
		if len(word) > 100: hyphenator.stdin.write(u'YLIPITKÄSANA\n'.encode('UTF-8'))
		else: hyphenator.stdin.write(word.encode('UTF-8') + '\n')
	(out, err) = hyphenator.communicate()
	rawlist = out.split('\n')
	hyphenatedlist = []
	for hword in rawlist:
		hyphenatedlist.append(_decode_if_valid(hword))
	return hyphenatedlist #FIXME: last item is an extra empty string

def _split_words(text):
	"""Splits the given text to words. Returns a list of words and list
	of word separators."""
	words = []
	separators = []
	prev_separator = u''
	linelength = 0
	for line in text.splitlines():
		for word in line.split():
			while len(word) > 1:
				if word[0].isalpha() or word[0] == u'-': break
				prev_separator = prev_separator + word[0]
				word = word[1:]
			separators.append(prev_separator)
			linelength = linelength + len(prev_separator)
			prev_separator = u' '
			while len(word) > 1:
				if word[-1].isalpha() or word[-1] == u'-' or \
				   (word[-1] == '.' and word[-2].isalpha()): break
				prev_separator = word[-1] + prev_separator
				word = word[:-1]
			words.append(word)
			linelength = linelength + len(word)
			if linelength > LINE_LENGTH:
				linelength = 0
				prev_separator = prev_separator + u'\n'
		prev_separator = prev_separator + u'\n'
		linelength = 0
	separators.append(prev_separator)
	return (words, separators)

def _hyphenated_to_html(word, hstyle):
	if hstyle == 'color':
		hyph_color_i = 0
		syllables = word.split('#')
		hyphenated = u''
		for syllable in syllables:
			hyphenated = hyphenated + u"<span style='background-color:"
			hyphenated = hyphenated + HYPH_COLORS[hyph_color_i]
			hyphenated = hyphenated + u"'>"
			hyphenated = hyphenated + _escape_html(syllable)
			hyphenated = hyphenated + u"</span>"
			hyph_color_i = (hyph_color_i + 1) % len(HYPH_COLORS)
		return hyphenated
	else:
		return _escape_html(word)

def hyphenate(req, hyphstring = None, htype = "normal", hmin = "2", hstyle = "hyphen"):
	req.content_type = "text/html; charset=UTF-8"
	req.send_http_header()
	_write(req, u'''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fi" lang="fi">
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
 <title>Voikko-tavuttaja</title>
 <link rel="stylesheet" type="text/css" href="../style.css" />
</head>
<body>
 <div class="topbar">
  <h1><a href="..">Joukahainen</a> &gt; <a href="../webvoikko">Webvoikko</a> &gt;
      Tavutus</h1>
  <div class="clear"></div>
  </div>
 <div class="main">
 <p>Tavutuksessa huomioitavaa:</p>
 <ul>
 <li>Monikäsitteisten yhdyssanojen kohdalla ohjelma ei yleensä ryhdy arvailemaan
  oikean tavurajan paikkaa, vaan antaa ainoastaan selvät jakokohdat. Siispä
  esimerkiksi "syysilta" tavuttuu "syysil-ta".</li>
 <li>Vierasperäisten tai vieraskielisten sanojen tavutus tehdään
  suomen kielen tavutussääntöjen mukaan, ellei Voikko satu tuntemaan kyseiselle sanalle
  parempaa tavujakoa.</li>
 </ul>
 ''')
	
	if hyphstring != None and len(hyphstring) > 0 and len(hyphstring) < MAX_INPUT_LENGTH:
		(words, separators) = _split_words(_decode_form_value(hyphstring))
		
		if htype == 'nougly': options = 'no_ugly_hyphenation=1'
		else: options = 'no_ugly_hyphenation=0'
		if hstyle == 'color': options = options + ' -s#'
		
		if hmin in ["2", "3", "4", "5", "6", "7", "8"]:
			options = options + " min_hyphenated_word_length=" + hmin
		hwords = _hyphenate_wordlist(words, options)
		_write(req, u'<p>Alla antamasi teksti tavutettuna:</p>\n')
		_write(req, u'<pre style="border: 1px solid black; background-color: white;')
		_write(req, u' font-size:1.3em; padding:3px; line-height: 1.5em;">')
		_write(req, _escape_html(separators[0]))
		for i in range(0, len(separators) - 1):
			_write(req, _hyphenated_to_html(hwords[i], hstyle))
			_write(req, _escape_html(separators[i + 1]))
		_write(req, u'</pre>\n')
	
	_write(req, u'''<form method="post" action="hyphenate">
	<p>Tavutustyyppi: <select name="htype">
	 <option selected="selected" value="normal">Normaali tavutus</option>
	 <option value="nougly">Huomioi yleisimmät typografiset käytänteet</option>
	 </select>
	</p>
	<p>Älä tavuta sanoja tai yhdyssanan osia, jotka ovat lyhyempiä kuin
	 <select name="hmin">
	 <option selected="selected" value="2">2</option>
	 <option value="3">3</option>
	 <option value="4">4</option>
	 <option value="5">5</option>
	 <option value="6">6</option>
	 <option value="7">7</option>
	 <option value="8">8</option>
	 </select>
	 merkkiä pitkiä.
	</p>
	<p>Merkitse tavurajat
	 <ul style="list-style-type:none">
	  <li><label><input type="radio" name="hstyle" value="hyphen" checked="checked" />yhdysmerkillä</li>
	  <li><label><input type="radio" name="hstyle" value="color" />vaihtuvalla taustavärillä</li>
	 </ul>
	</p>
	<p>Kirjoita alla olevaan kenttään teksti, jonka haluat tavuttaa, ja paina "Tavuta".</p>
	<p><textarea name="hyphstring" rows="15" style="width:100%">''')
	if hyphstring != None:
		_write(req, _escape_html(_decode_form_value(hyphstring)))
	_write(req, u'''</textarea></p>
	<p><input type="submit" value="Tavuta" /></p>
	</form>
	</div></body></html>
	''')

def spell(req, spellstring = None):
	req.content_type = "text/html; charset=UTF-8"
	req.send_http_header()
	_write(req, u'''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fi" lang="fi">
 <head>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <title>Voikko &mdash; suomen kielen oikoluku</title>
  <link rel="stylesheet" type="text/css" href="../style.css" />
  <link type="text/css"
   href="http://jqueryui.com/latest/themes/base/ui.all.css"
   rel="stylesheet" />
  <link type="text/css" href="../ajaxvoikko-style.css" rel="stylesheet" />
  <script type="text/javascript" src="http://www.google.com/jsapi"></script>
  <script type="text/javascript" src="../ajaxvoikko-script.js"></script>
 </head>
 <body>
 <div class="topbar">
  <h1><a href="..">Joukahainen</a> &gt; <a href="../webvoikko">Webvoikko</a> &gt;
      Oikoluku</h1>
  <div class="clear"></div>
  </div>
 <div class="main">
  <p>Kirjoita teksti tähän:</p>
  <textarea id="input" rows="5"></textarea>
  <div id="progress"></div>
  <p>Lue analyysin tulokset alta. Lisää tietoja sanoista tai virheistä saat hiirellä napsauttamalla.</p>
  <div id="result"></div>
 </div>
 </body>
</html>
 ''')

def _poErrorHeader(headerLine):
	"""Returns formatted version of pofilter output describing the spelling
	errors in given msgtxt item."""
	errors = headerLine.split(", check spelling of ")
	out = u""
	for error in errors:
		sepIndex = error.find(" ")
		word = error[:sepIndex]
		out += "\n<span class='virhe'>" + _escape_html(word) + "</span> "
		out += "(" + _escape_html(error[sepIndex+11:])
	return out

def _highlightPofilter(req, file):
	"""Reads pofilter output from a file and writes it to request with highlighting."""
	line = _decode_if_valid(file.readline())
	while line != "":
		if line.startswith("# (pofilter) spellcheck:"):
			_write(req, _poErrorHeader(line[43:]))
		elif line.startswith("#"):
			pass
		else:
			_write(req, _escape_html(line))
		line = _decode_if_valid(file.readline())

PO_FILE_TYPES = [
	(u"gnome", u"Gnome (tai muu kuin jokin alla olevista)"),
	(u"kde", u"KDE"),
	(u"mozilla", u"Mozilla"),
	(u"openoffice", u"OpenOffice.org")
]

def _poFileTypeCombo(req, potype):
	"""Writes the file type combo box to the request"""
	_write(req, u'<select name="potype">\n')
	for fileType in PO_FILE_TYPES:
		_write(req, u'<option value="' + fileType[0] + '"')
		if fileType[0] == potype:
			_write(req, u' selected="selected"')
		_write(req, u'>' + fileType[1] + u"</option>\n")
	_write(req, u'</select>\n')

def pospell(req, pofile = None, potype = "gnome"):
	req.content_type = "text/html; charset=UTF-8"
	req.send_http_header()
	_write(req, u'''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fi" lang="fi">
 <head>
  <title>Po-oikolukija</title>
  <link rel="stylesheet" type="text/css" href="../style.css" />
  <style type="text/css">
    span.virhe { font-size: 1.3em; color: #bb0000; font-weight: bold }
  </style>
 </head>
 <body>
 <div class="topbar">
  <h1><a href="..">Joukahainen</a> &gt; <a href="../webvoikko">Webvoikko</a> &gt;
      Po-oikoluku</h1>
  <div class="clear"></div>
  </div>
 <div class="main">
 <ul>
 <li>Toistaiseksi vain UTF-8-koodattujen
     <acronym title="GNU Gettext Portable Object">po-tiedostojen</acronym> oikoluku on
     mahdollista tämän www-liittymän kautta.</li>
 <li>Oikoluettavan tiedoston enimmäiskoko on %s kilotavua.</li>
 <li>Tämä www-palvelu ei osaa aina käsitellä oikein kaksoispisteen tai yhdysmerkin
     sisältäviä sanoja.
     Osa näistä ongelmista korjataan tulevissa versioissa. Muista sanasto-ongelmista
     voi raportoida <a href="http://joukahainen.lokalisointi.org/ehdotasanoja">Voikon
     kehittäjille</a>.</li>
 </ul>
 <form enctype="multipart/form-data" method="post" action="">
 <p>Oikoluettava po-tiedosto: <input type="file" name="pofile" /><br />
 Sovelluksen tyyppi:
 ''' % MAX_PO_SIZE)
	_poFileTypeCombo(req, potype)
	_write(req, u'<input type="submit" value="Oikolue!" /></p></form>\n')
	
	if pofile != None and hasattr(pofile, "filename"):
		if not potype in ["gnome", "kde", "mozilla", "openoffice"]:
			potype = "gnome"
		_write(req, (u'<p>Alla po-tiedoston <kbd>%s</kbd> (tyyppi %s) oikoluvun tulokset. ' + \
		    u'Mahdolliset kirjoitusvirheet on värjätty punaiseksi.</p>\n') % \
		    (_escape_html(pofile.filename), potype))
		_write(req, u'<pre style="border: 1px solid black">')
		poInputFile = pofile.file
		(inTempHandle, inTempName) = mkstemp(".po")
		inTempFile = os.fdopen(inTempHandle, "w")
		inTempFile.write(poInputFile.read(MAX_PO_SIZE * 1024))
		inTempFile.close()
		if (len(poInputFile.read(1)) > 0):
			_write(req, u"<i>(lähettämäsi tiedosto on liian suuri)</i>")
			os.remove(inTempName)
			return ""
		(outTempHandle, outTempName) = mkstemp(".po")
		env = {"VOIKKO_DICTIONARY_PATH": POFILTER_DICT_DIR}
		p = subprocess.Popen([POFILTERCOMMAND, "--lang=fi", "-tspellcheck",
		                      "--" + potype, "-i", inTempName,
		                      "-o", outTempName], env=env)
		p.wait()
		os.remove(inTempName)
		outTempFile = os.fdopen(outTempHandle, "r")
		_highlightPofilter(req, outTempFile)
		outTempFile.close()
		try:
			os.remove(outTempName)
		except:
			_write(req, u"<i>(ei virheitä)</i>")
		_write(req, u'</pre>\n')
	
	_write(req, u'</div></body></html>\n')


def index(req, spellstring = None):
	req.content_type = "text/html; charset=UTF-8"
	req.send_http_header()
	_write(req, u'''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
     "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fi" lang="fi">
 <head>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  <title>Webvoikko</title>
  <link rel="stylesheet" type="text/css" href="style.css" />
 </head>
 <div class="topbar">
  <h1><a href=".">Joukahainen</a> &gt; Webvoikko</h1>
  <div class="clear"></div>
  </div>
 <div class="main">
 <p>Tämä on <a href="http://voikko.puimula.org">Voikko-projektin</a> tarjoama oikoluku- ja
 tavutuspalvelu, jonka on ensisijainen tarkoitus on toimia helppokäyttöisenä testiympäristönä
 Voikon kehittäjiä varten. Palvelua saa kuitenkin käyttää muutenkin, esimerkiksi Voikon
 testaamiseen ennen ohjelmiston käyttöönottoa tai tekstien oikolukuun silloin kun omalla koneella
 ei satu olemaan käytettävissä toimivaa oikolukuohjelmaa. Seuraavat rajoitteet
 kannattaa huomioida:</p>
 <ul>
  <li>Oikoluettavien ja tavutettavien sanojen pituus on rajattu sataan merkkiin, ja tekstin
   yhteispituuttakin rajoitetaan.</li>
  <li>Ohjelma käsittelee vain suomenkielistä tekstiä. Älä yritä tavuttaa tai etenkään oikolukea muun
   kielisiä tekstejä, tämä vain kuluttaa turhaan palvelimen prosessoriaikaa.</li>
  <li>Palveluun lähetettäviä tekstejä ei tallenneta mihinkään, joten periaatteessa kukaan ulkopuolinen
   ei voi lukea tekstejä jotka sinne on lähetetty. Käytännössä mm. salaamattomat yhteydet heikentävät
   tätä turvaa jonkin verran, joten ei ole suositeltavaa lähettää oikoluettavaksi tai tavutettavaksi
   mitään kovin arkaluontoista materiaalia. Kaikilta osin palvelun käyttö tapahtuu käyttäjän omalla
   vastuulla.</li>
  <li>Oikolukupalvelu ei toimi ilman JavaScriptiä.</li>
  <li>Palvelua ei ole tarkoitettu korvaamaan tavallista oikoluku- tai tavutusohjelmaa.</li>
  <li>Palvelussa käytettävä versio Voikosta ei yleensä ole ns. "vakaa versio". Koska kyseessä on
   testiversio, se saattaa sisältää virheitä, joita vakaissa versioissa ei ole.
   Havaituista virheistä voi ilmoittaa sähköpostitse osoitteeseen hatapitk@iki.fi.</li>
 </ul>
 <ul>
  <li><a href="/webvoikko/spell">Siirry oikolukupalveluun</a></li>
  <li><a href="/webvoikko/hyphenate">Siirry tavutuspalveluun</a></li>
  <li><a href="/webvoikko/pospell">Siirry po-tiedostojen oikolukupalveluun</a></li>
 </ul>
 <p>Webvoikko (kuten Voikko muutenkin) on kokonaisuudessaan vapaata ohjelmistoa. Se on saatavilla
  maksutta GPL-lisenssillä, joten jos haluat, voit asentaa ohjelmiston myös omalle palvelimellesi
  ja muokata sitä tarpeittesi mukaan.
  <a href="http://voikko.puimula.org">Voikko-projektin</a> kotisivuilta löydät lisää tietoa
  asiasta sekä yhteystietomme.
 </p>
 </div>
 </body>
 </html>
 ''')
