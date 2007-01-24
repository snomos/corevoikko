# -*- coding: utf-8 -*-

# Copyright 2007 Harri Pitkänen (hatapitk@iki.fi)
# Web interface for Finnish linguistic tools based on Voikko

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

# This file contains tools to find inflection class for a word

from mod_python import apache

import sys
import subprocess
import urllib
import xml.sax.saxutils

# Hyphenator and spell checker commands
HYPHCOMMAND = 'LC_CTYPE="fi_FI.UTF-8" voikkohyphenate no_ugly_hyphenation=0 ignore_dot=1'
SPELLCOMMAND = 'LC_CTYPE="fi_FI.UTF-8" voikkospell -s -t ignore_dot=1'

def _write(req, text):
	req.write(text.encode('UTF-8'))

# Decodes a string from html form to unicode
def _decode_form_value(string):
	return unicode(urllib.unquote_plus(string), 'UTF-8')

# Converts a string to a form that is suitable for use in html document text
def _escape_html(string):
	return xml.sax.saxutils.escape(string)

def _hyphenate_wordlist(wordlist):
	hyphenator = subprocess.Popen(HYPHCOMMAND, shell = True, stdin = subprocess.PIPE,
	                              stdout = subprocess.PIPE, close_fds = True)
	for word in wordlist:
		if len(word) > 100: hyphenator.stdin.write(u'YLIPITKÄSANA\n'.encode('UTF-8'))
		else: hyphenator.stdin.write(word.encode('UTF-8') + '\n')
	(out, err) = hyphenator.communicate()
	rawlist = out.split('\n')
	hyphenatedlist = []
	for hword in rawlist:
		hyphenatedlist.append(unicode(hword, 'UTF-8'))
	return hyphenatedlist #FIXME: last item is an extra empty string

def _spell_wordlist(wordlist):
	speller = subprocess.Popen(SPELLCOMMAND, shell = True, stdin = subprocess.PIPE,
	                           stdout = subprocess.PIPE, close_fds = True)
	for word in wordlist:
		if len(word) > 100: speller.stdin.write(u'YLIPITKÄSANA\n'.encode('UTF-8'))
		else: speller.stdin.write(word.encode('UTF-8') + '\n')
	(out, err) = speller.communicate()
	rawlist = out.split('\n')
	spellresults = []
	i = 0
	while i < len(rawlist):
		if len(rawlist[i]) == 0: break
		if rawlist[i] == 'C':
			spellresults.append(None)
			i = i + 1
			continue
		else:
			suggestions = []
			i = i + 1
			entry = unicode(rawlist[i], 'UTF-8')
			while entry.startswith(u'S'):
				suggestions.append(entry[3:])
				i = i + 1
				entry = unicode(rawlist[i], 'UTF-8')
			spellresults.append(suggestions)
	return spellresults

def _split_words(text):
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
			if linelength > 100:
				linelength = 0
				prev_separator = prev_separator + u'\n'
		prev_separator = prev_separator + u'\n'
		linelength = 0
	separators.append(prev_separator)
	return (words, separators)

def hyphenate(req, hyphstring = None):
	req.content_type = "text/html; charset=UTF-8"
	req.send_http_header()
	_write(req, u'''
<html>
<head>
 <title>Voikko-tavuttaja</title>
</head>
<body>
 <p><a href="/webvoikko">Webvoikon etusivulle</a></p>
 <h1>Voikko-tavuttaja</h1>
 <p>Tavutuksessa huomioitavaa:</p>
 <ul>
 <li>Käytetty tavutussäännöstö ei ole sama, jota openoffice.org-voikko käyttää.</li>
 <li>Monikäsitteisten yhdyssanojen kohdalla ohjelma ei yleensä ryhdy arvailemaan
  oikean tavurajan paikkaa, vaan antaa ainoastaan selvät jakokohdat. Siispä
  esimerkiksi "syysilta" tavuttuu "syysil-ta".</li>
 <li>Vierasperäisten tai vieraskielisten sanojen tavutus tehdään
  suomen kielen tavutussääntöjen mukaan, ellei Voikko satu tuntemaan kyseiselle sanalle
  parempaa tavujakoa.</li>
 </ul>
 ''')
	
	if hyphstring != None and len(hyphstring) > 0:
		(words, separators) = _split_words(_decode_form_value(hyphstring))
		hwords = _hyphenate_wordlist(words)
		_write(req, u'<p>Alla antamasi teksti tavutettuna:</p>\n')
		_write(req, u'<pre style="border: 1px solid black">')
		_write(req, _escape_html(separators[0]))
		for i in range(0, len(separators) - 1):
			_write(req, _escape_html(hwords[i]))
			_write(req, _escape_html(separators[i + 1]))
		_write(req, u'</pre>\n')
	
	_write(req, u'<form method="post" action="hyphenate">\n')
	_write(req, u'<p>Kirjoita alla olevaan kenttään teksti, jonka haluat tavuttaa, ja\n')
	_write(req, u'paina "Tavuta".</p>\n')
	_write(req, u'<textarea name="hyphstring" rows="30" cols="90"></textarea>\n')
	_write(req, u'<p><input type="submit" value="Tavuta" /></p>\n')
	_write(req, u'</form>\n')
	_write(req, u'</body></html>\n')

def spell(req, spellstring = None):
	req.content_type = "text/html; charset=UTF-8"
	req.send_http_header()
	_write(req, u'''
 <html>
 <head>
  <title>Voikko-oikolukija</title>
  <style type="text/css">
    span.virhe { color: red; }
    span.virhe_ehdotukset { color: red; text-decoration: underline; }
  </style>
 </head>
 <p><a href="/webvoikko">Webvoikon etusivulle</a></p>
 <h1>Voikko-oikolukija</h1>
 ''')
	
	if spellstring != None and len(spellstring) > 0:
		(words, separators) = _split_words(_decode_form_value(spellstring))
		spellresults = _spell_wordlist(words)
		_write(req, u'<p>Alla antamasi teksti oikoluettuna. Virheelliset sanat on ' \
		          + u'värjätty punaiseksi. Punaisella värillä alleviivatuille sanoille ' \
			+ u'on saatavilla korjausehdotuksia, jotka tulevat näkyviin kun hiiren ' \
			+ u'osoittimen siirtää sanan päälle.</p>\n')
		_write(req, u'<pre style="border: 1px solid black">')
		_write(req, _escape_html(separators[0]))
		for i in range(0, len(separators) - 1):
			if spellresults[i] == None:
				_write(req, _escape_html(words[i]))
			elif len(spellresults[i]) == 0:
				_write(req, u'<span class="virhe">' \
				       + _escape_html(words[i]) + u'</span>')
			else:
				_write(req, u'<span class="virhe_ehdotukset" title="')
				_write(req, _escape_html(reduce(lambda x, y: u"%s; %s" \
				       % (x, y), spellresults[i])))
				_write(req, u'">' + _escape_html(words[i]) + u'</span>')
			_write(req, _escape_html(separators[i + 1]))
		_write(req, u'</pre>\n')
	
	_write(req, u'<form method="post" action="spell">\n')
	_write(req, u'<p>Kirjoita alla olevaan kenttään teksti, jonka haluat oikolukea, ja\n')
	_write(req, u'paina "Oikolue".</p>\n')
	_write(req, u'<textarea name="spellstring" rows="30" cols="90"></textarea>\n')
	_write(req, u'<p><input type="submit" value="Oikolue" /></p>\n')
	_write(req, u'</form>\n')
	_write(req, u'</body></html>\n')

def index(req, spellstring = None):
	req.content_type = "text/html; charset=UTF-8"
	req.send_http_header()
	_write(req, u'''
 <html>
 <head>
  <title>Webvoikko</title>
 </head>
 <h1>Webvoikko</h1>
 <p>Tämä on <a href="http://voikko.sourceforge.net">Voikko-projektin</a> tarjoama oikoluku- ja
 tavutuspalvelu, jonka on ensisijainen tarkoitus on toimia helppokäyttöisenä testiympäristönä
 Voikon kehittäjiä varten. Palvelua saa kuitenkin käyttää muutenkin, esimerkiksi Voikon
 testaamiseen ennen ohjelmiston käyttöönottoa tai tekstien oikolukuun silloin kun omalla koneella
 ei satu olemaan käytettävissä toimivaa oikolukuohjelmaa. Seuraavat rajoitteet
 kannattaa huomioida:</p>
 <ul>
  <li>Oikoluettavien ja tavutettavien sanojen pituus on rajattu sataan merkkiin. Sanojen määrää
   tai ohjelman käyttökertoja ei ole rajattu, mutta kovin pitkien tekstien käsitteleminen turhaan
   ei ole suositeltavaa, jottei tällaisia rajoituksia tarvitsisi myöhemmin lisätä.</li>
  <li>Jos tekstissä on muutakin kuin tavallisia sanoja (esim. url-osoitteita),
   myös ne käsitellään kuin ne olisivat sanoja.</li>
  <li>Ohjelma käsittelee vain suomenkielistä tekstiä. Älä yritä tavuttaa tai etenkään oikolukea muun
   kielisiä tekstejä, tämä vain kuluttaa turhaan palvelimen prosessoriaikaa.</li>
  <li>Palveluun lähetettäviä tekstejä ei tallenneta mihinkään, joten periaatteessa kukaan ulkopuolinen
   ei voi lukea tekstejä jotka sinne on lähetetty. Käytännössä mm. salaamattomat yhteydet heikentävät
   tätä turvaa jonkin verran, joten ei ole suositeltavaa lähettää oikoluettavaksi tai tavutettavaksi
   mitään kovin arkaluontoista materiaalia. Kaikilta osin palvelun käyttö tapahtuu käyttäjän omalla
   vastuulla.</li>
  <li>Palvelua ei ole tarkoitettu korvaamaan tavallista oikoluku- tai tavutusohjelmaa.</li>
  <li>Palvelussa käytettävä versio Voikosta ei yleensä ole ns. "vakaa versio" vaan
   jokin suhteellisen toimivaksi havaittu kehitysversio. Palvelua yritetään päivittää silloin
   tällöin niin, että se suunnilleen kuvastaisi Voikon nykyistä toiminnallisuutta. Koska kyseessä
   kuitenkin on testiversio, se saattaa sisältää virheitä joita vakaissa versioissa ei ole.
   Havaituista virheistä voi ilmoittaa sähköpostitse osoitteeseen
   <a href="mailto:palaute@hunspell-fi.org">palaute@hunspell-fi.org</a>.</li>
 </ul>
 <ul>
  <li><a href="/webvoikko/spell">Siirry oikolukupalveluun</a></li>
  <li><a href="/webvoikko/hyphenate">Siirry tavutuspalveluun</a></li>
 </ul>
 <p>Webvoikko (kuten Voikko muutenkin) on kokonaisuudessaan vapaata ohjelmistoa. Se on saatavilla
  maksutta GPL-lisenssillä, joten jos haluat, voit asentaa ohjelmiston myös omalle palvelimellesi
  ja muokata sitä tarpeittesi mukaan.
  <a href="http://voikko.sourceforge.net">Voikko-projektin</a> kotisivuilta löydät lisää tietoa
  asiasta sekä yhteystietomme.
 </p>
 </body>
 </html>
 ''')
