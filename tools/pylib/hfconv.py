# -*- coding: utf-8 -*-

# Copyright 2005, 2006 Harri Pitkänen (hatapitk@cc.jyu.fi)
# Functions and data for Hunspell-fi <-> Suomi-malaga converter

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

import re

grads = [ (u'sw', u'tt', u'av1'),
	(u'sw', u'pp', u'av1'),
	(u'sw', u'kk', u'av1'),
	(u'sw', u'mp', u'av1'),
	(u'sw', u'p', u'av1'),
	(u'sw', u'nt', u'av1'),
	(u'sw', u'lt', u'av1'),
	(u'sw', u'rt', u'av1'),
	(u'sw', u't', u'av1'),
	(u'sw', u'nk', u'av1'),
	(u'sw', u'uku', u'av1'),
	(u'sw', u'yky', u'av1'),
	(u'ws', u't', u'av2'),
	(u'ws', u'p', u'av2'),
	(u'ws', u'k', u'av2'),
	(u'ws', u'mm', u'av2'),
	(u'ws', u'v', u'av2'),
	(u'ws', u'nn', u'av2'),
	(u'ws', u'll', u'av2'),
	(u'ws', u'rr', u'av2'),
	(u'ws', u'd', u'av2'),
	(u'ws', u'ng', u'av2'),
	(u'sw', u'k>j', u'av3'),
	(u'ws', u'j>k', u'av4'),
	(u'sw', u'k>', u'av5'),
	(u'ws', u'>k', u'av6')   ]

# Joukahainen word classes
SUBST = 1
ADJ = 2
VERB = 3

classmap = [(u'valo', u'sw', [(None,u'(.*)',u'valo'),
			(u'k>',u'(ko)ko',u'koko'),
			(u'k>',u'(ruo)ko',u'ruoko'),
			(u'kk',u'(.*k)kU',u'alku'),
			(u'uku',u'(.U)kU',u'luku'),
			(u'k>',u'(..U)kU',u'tiuku'),
			(u'k>',u'(.*)kU',u'alku'),
			(u'lt',u'(.*l)tO',u'aalto'),
			(u'nt',u'(.*n)tO',u'anto'),
			(u'nt',u'(.*n)tU',u'lintu'),
			(u'nk',u'(.*n)kO',u'hanko'),
			(u'tt',u'(.*t)tU',u'hattu'),
			(u'tt',u'(.*t)tO',u'liitto'),
			(u'nk',u'(.*n)kU',u'hinku'),
			(u'pp',u'(.*p)pU',u'hoppu'),
			(u'rt',u'(.*r)tO',u'kaarto'),
			(u'pp',u'(.*p)pO',u'kippo'),
			(u'mp',u'(.*m)pO',u'sampo'),
			(u'mp',u'(.*m)pU',u'kumpu'),
			(u't',u'(.*)tU',u'laatu'),
			(u'p',u'(.*)pU',u'apu'),
			(u'p',u'(.*)pO',u'lepo'),
			(u't',u'(.*)tO',u'leuto'),
			(u'kk',u'(.*k)kO',u'verkko'),
			(u'k>',u'(.*h)kO',u'vihko'),
			(u'k>',u'(.*)kO',u'verkko')   ]),
	(u'arvelu', u'sw', [(None,u'(.*Ce[lr])O',u'hontelo',[ADJ]),
			(None,u'(.*)',u'arvelu'),
			(u'nk',u'(.*n)kO',u'alanko'),
			(u'nt',u'(.*n)tO',u'avanto'),
			(u'kk',u'(.*k)kO',u'laatikko'),
			(u'tt',u'(.*t)tO',u'pihatto'),
			(u'tt',u'(.*t)tU',u'raamattu') ]),
	(u'autio', u'-', [(None,u'(.*)',u'autio')]),
	(u'kiiski', u'-', [(None,u'(.*)i',u'kiiski')]),
	(u'risti', u'sw', [(None,u'(.*)i',u'risti'),
			(u'pp',u'(.*p)pi',u'keppi'),
			(u'lt',u'(.*l)ti',u'pelti'),
			(u'nk',u'(.*n)ki',u'renki'),
			(u'kk',u'(.*k)ki',u'takki'),
			(u'tt',u'(.*t)ti',u'tatti'),
			(u'nt',u'(.*n)ti',u'tunti'),
			(u'p',u'(.*)pi',u'hupi'),
			(u't',u'(.*)ti',u'vati'),
			(u'k>',u'(.*)ki',u'takki')]),
	(u'paperi', u'sw', [(None,u'(.*)i',u'paperi'),
			(u'nt',u'(.*n)ti',u'hollanti'),
			(u'nk',u'(.*n)ki',u'killinki'),
			(u'kk',u'(.*k)ki',u'kajakki'),
			(u'tt',u'(.*t)ti',u'salaatti'),
			(u'pp',u'(.*p)pi',u'sinappi'),
			(u't',u'(.*)ti',u'konvehti') ]),
	(u'edam', u'-', [(None,u'(.*C)',u'edam')]),
	(u'kalsium', u'sw', [(None,u'(.*)i',u'fan'),
			(None,u'(.*)',u'kalsium'),
			(u'pp',u'(.*p)pi',u'pop'),
			(u'kk',u'(.*k)ki',u'punk')]),
	(u'lovi', u'sw',   [(None,u'(.*)i',u'lovi'),
			(u'nk',u'(.*n)ki',u'hanki'),
			(u'pp',u'(.*p)pi',u'happi'),
			(u'mp',u'(.*m)pi',u'sampi'),
			(u'kk',u'(.*k)ki',u'kaikki'),
			(u'k>j',u'(.*)ki',u'kylki'),
			(u't',u'(.*lah)ti',u'lahti'),
			(u't',u'(.*h)ti',u'lehti'),
			(u'p',u'(.*)pi',u'siipi'),
			(u'k>',u'(.*)ki',u'kaikki')]),
	(u'nalle', u'sw', [(None,u'(.*Ce)',u'nalle'),
		         (u'tt',u'(.*t)te',u'atte'),
		         (u'kk',u'(.*k)ke',u'nukke')]),
	(u'kala', u'sw',   [(None,u'(.*)A',u'kala'),
			(u'tt',u'(.*t)tA',u'aitta'),
			(u'nk',u'(.*n)kA',u'hanka'),
			(u'mp',u'(.*m)pA',u'kampa'),
			(u'nt',u'(.*n)tA',u'kanta'),
			(u'pp',u'(.*p)pA',u'kappa'),
			(u'rt',u'(.*r)tA',u'parta'),
			(u'lt',u'(.*l)tA',u'valta'),
			(u'kk',u'(.*k)kA',u'haka'),
			(u'p',u'(.*)pA',u'napa'),
			(u't',u'(.*)tA',u'pata'),
			(u'k>',u'(.*AA)kA',u'raaka'),
			(u'k>',u'(.*)kA',u'haka')]),
	(u'koira', u'sw',   [(None,u'(.*)A',u'koira'),
			(u'tt',u'(.*t)tA',u'kenttä'),
			(u'nk',u'(.*n)kA',u'honka'),
			(u'mp',u'(.*m)pA',u'kompa'),
			(u'nt',u'(.*n)tA',u'suunta'),
			(u'pp',u'(.*p)pA',u'tolppa'),
			(u'rt',u'(.*r)tA',u'turta'),
			(u'lt',u'(.*l)tA',u'kulta'),
			(u'kk',u'(.*k)kA',u'hoikka'),
			(u'p',u'(.*)pA',u'huopa'),
			(u't',u'(.*)tA',u'juhta'),
			(u'k>',u'(.*)kA',u'hoikka')]),
	(u'matala', u'-', [(None,u'(.*C)A',u'matala')]),
	(u'asema', u'sw',  [(None,u'(.*)A',u'asema'),
			(u'nt',u'(.*n)tA',u'emäntä')]),
	(u'kulkija', u'-', [(None,u'(.*i)jA',u'kulkija'),
			(None,u'(.*)A',u'apila')]),
	(u'karahka', u'sw', [(None,u'(.*)A',u'karahka'),
			(u'tt',u'(.*t)tA',u'savotta'),
			(u'pp',u'(.*p)pA',u'ulappa'),
			(u'kk',u'(.*k)kA',u'solakka')]),
	(u'apaja', u'-', [(None,u'(.*C)A',u'apaja')]),
	(u'peruna', u'-', [(None,u'(.*C)A',u'peruna')]),
	(u'herttua', u'-', [(None,u'(.*tU)A',u'herttua')]),
	(u'korkea', u'-', [(None,u'(.*C)eA',u'korkea'),
		         (None,u'(.*O)A',u'ainoa')]),
	(u'suurempi', u'sw', [(u'mp',u'(.*V)mpi',u'suurempi')]),
	(u'vapaa', u'-', [(None,u'(.*CA)A',u'vapaa'),
		        (None,u'(.*CO)O',u'tienoo'),
		        (None,u'(.*CU)U',u'leikkuu')]),
	(u'kamee', u'-',   [(None,u'(.*Ce)e',u'kamee'),
			(None,u'(.*CO)O',u'trikoo'),
			(None,u'(.*CU)U',u'revyy')]),
	(u'pii', u'-', [(None,u'(.*V)i',u'pii'),
		      (None,u'(.*CA)A',u'maa'),
		      (None,u'(.*U)U',u'puu')]),
	(u'suo', u'-', [(None,u'(.*C)UO',u'suo')]),
	(u'rosé', u'-', [(None,u'(.*V)',u'rosé')]),
	(u'parfait', u'-', [(None,u'(.*VC)',u'parfait')]),
	(u'huuli', u'-', [(None,u'(.*C)i',u'tuohi')]),
	(u'tuohi', u'-', [(None,u'(.*C)i',u'lohi')]),
	(u'niemi', u'-', [(None,u'(.*V)mi',u'niemi')]),
	(u'lumi', u'-', [(None,u'(.*V)mi',u'lumi')]),
	(u'susi', u'-', [(None,u'(.*V)si',u'susi')]),
	(u'sisar', u'ws', [(None,u'(.*CVC)',u'sisar'),
		         (u't',u'(.*t)Ar',u'tytär')]),
	(u'uistin', u'ws', [(None,u'(.*i)n',u'uistin'),
	                    (u'nn',u'(.*n)nin',u'vaimennin'),
		          (u'll',u'(.*l)lin',u'sivellin'),
		          (u'rr',u'(.*r)rin',u'kiharrin'),
		          (u'd',u'(.*)din',u'kaadin'),
		          (u'v',u'(.*)vin',u'kaavin'),
			(u't',u'(.*t)in',u'suodatin'),
		          (u'j>k',u'(.*l)jin',u'poljin'),
		          (u'>k',u'(.*)in',u'puin')]),
	(u'nainen', u'-', [(None,u'(.*)nen',u'nainen')]),
	(u'vastaus', u'-', [(None,u'(.*V)s',u'vastaus')]),
	(u'kalleus', u'-', [(None,u'(.*VU)s',u'kalleus'),
	                    (None,u'(.*vU)s',u'kalleus')]),
	(u'vieras', u'ws', [(None,u'(.*A)s',u'vieras'),
	                    (None,u'(.*)is',u'kauris'),
	                    (u'nn',u'(.*n)nAs',u'kinnas'),
		          (u'll',u'(.*l)lAs',u'allas'),
		          (u'rr',u'(.*r)rAs',u'harras'),
		          (u'mm',u'(.*m)mAs',u'hammas'),
		          (u'ng',u'(.*n)gAs',u'kangas'),
			(u'k',u'(.*k)As',u'avokas',[SUBST]),
			(u'k',u'(.*k)As',u'vilkas',[ADJ]),
		          (u'p',u'(.*p)As',u'saapas'),
		          (u'd',u'(.*)dAs',u'ahdas'),
		          (u'v',u'(.*)vAs',u'varvas'),
		          (u't',u'(.*t)As',u'ratas'),
		          (u'>k',u'(.*)As',u'varas'),
			(u'>k',u'(.*)is',u'ruis')]),
	(u'iäkäs', u'ws', [(u'k',u'(.*k)As',u'iäkäs',[ADJ])]),
	(u'kuollut', u'-', [(None,u'(.*C)Ut',u'kuollut')]),
	(u'hame', u'ws', [(None,u'(.*e)',u'hame'),
	                  (u'nn',u'(.*n)ne',u'enne'),
		        (u'll',u'(.*l)le',u'helle'),
		        (u'rr',u'(.*r)re',u'kierre'),
		        (u'mm',u'(.*m)me',u'lumme'),
		        (u'j>k',u'(.*C)je',u'lahje'),
		        (u'p',u'(.*p)e',u'lape'),
		        (u'd',u'(.*)de',u'sade'),
		        (u'v',u'(.*)ve',u'taive'),
		        (u'k',u'(.*k)e',u'tarvike'),
		        (u'>k',u'(.*V)e',u'tarvike'),
		        (u't',u'(.*Vt)e',u'vaate')]),
	# Verbs
	(u'punoa', u'sw', [(None,u'(.*)A',u'punoa'),
	                   (u'mp',u'(.*m)pUA',u'ampua'),
	                   (u'mp',u'(.*m)pOA',u'tempoa'),
		         (u'tt',u'(.*t)tUA',u'asettua'),
		         (u'tt',u'(.*t)tOA',u'viittoa'),
		         (u'pp',u'(.*p)pOA',u'harppoa'),
		         (u'pp',u'(.*p)pUA',u'kieppua'),
		         (u'nt',u'(.*n)tUA',u'jakaantua'),
		         (u'rt',u'(.*r)tOA',u'kertoa'),
		         (u'rt',u'(.*r)tUA',u'kumartua'),
		         (u'nk',u'(.*n)kUA',u'mankua'),
		         (u'nk',u'(.*n)kOA',u'penkoa'),
		         (u'lt',u'(.*l)tUA',u'paleltua'),
		         (u't',u'(.*)tUA',u'kaatua'),
		         (u't',u'(.*)tOA',u'tahtoa'),
		         (u'p',u'(.*)pOA',u'leipoa'),
		         (u'p',u'(.*)pUA',u'saapua'),
		         (u'k>',u'(.*U)kUA',u'liukua'),
		         (u'k>',u'(.*)kOA',u'aikoa'),
		         (u'k>',u'(.*)kUA',u'kiekua')]),
	(u'aavistaa', u'sw', [(None,u'(.*t)AA',u'aavistaa'),
	                      (u'tt',u'(.*t)tAA',u'alittaa'),
			  (u't',u'(.*h)tAA',u'astahtaa')]),
	(u'hidastaa', u'-', [(None,u'(.*t)AA',u'hidastaa')]),
	(u'heittää', u'sw', [(u'tt',u'(.*t)tAA',u'heittää')]),
	(u'muistaa', u'-', [(None,u'(.*C)AA',u'muistaa')]),
	(u'inttää', u'sw', [(u'tt',u'(.*t)tAA',u'inttää')]),
	(u'sulaa', u'sw', [(None,u'(.*C)AA',u'sulaa'),
	                   (u'nt',u'(.*n)tAA',u'kyntää'),
		         (u'tt',u'(.*t)tAA',u'autioittaa'),
		         (u'k>',u'(.*C)kAA',u'purkaa')]),
	(u'hohtaa', u'sw', [(u't',u'(.*)tAA',u'hohtaa')]),
	(u'hujahtaa', u'sw', [(u't',u'(.*V)htAA',u'hujahtaa')]),
	(u'kirjoittaa', u'sw', [(u'tt',u'(.*V)ittAA',u'kirjoittaa'),
			    (u'tt',u'(.*V)ttAA',u'ammottaa')]),
	(u'loistaa', u'-', [(None,u'(.*C)AA',u'loistaa')]),
	(u'vuotaa', u'sw', [(u'lt',u'(.*Vl)tAA',u'puoltaa'),
			(u't',u'(.*V)tAA',u'vuotaa')]),
	(u'huutaa', u'sw', [(u'nt',u'(.*Vn)tAA',u'huutaa'),
			(u't',u'(.*V)tAA',u'huutaa')]),
	(u'sukeltaa', u'sw', [(u'lt',u'(.*Vl)tAA',u'sukeltaa'),
			  (u'rt',u'(.*Vr)tAA',u'musertaa')]),
	(u'paleltaa', u'sw', [(u'lt',u'(.*Vl)tAA',u'paleltaa')]),
	(u'murtaa', u'sw', [(u'rt',u'(.*Vr)tAA',u'murtaa')]),
	(u'juontaa', u'sw', [(u'nt',u'(.*Vn)tAA',u'juontaa')]),
	(u'pahentaa', u'sw', [(u'nt',u'(.*Vn)tAA',u'pahentaa')]),
	(u'soutaa', u'sw', [(u't',u'(.*V)tAA',u'soutaa')]),
	(u'laskea', u'sw', [(None,u'(.*C)eA',u'laskea'),
	                    (u'nk',u'(.*n)keA',u'tunkea'),
			(u't',u'(.*)teA',u'kutea'),
			(u'kk',u'(.*k)keA',u'hakea'),
			(u'p',u'(.*)peA',u'rypeä'),
			(u'k>j',u'(.*)keA',u'polkea'),
			(u'k>',u'(.*)keA',u'hakea')]),
	(u'sallia', u'sw', [(None,u'(.*C)iA',u'sallia'),
			(u'nk',u'(.*n)kiA',u'onkia'),
			(u'mp',u'(.*m)piA',u'empiä'),
			(u'nt',u'(.*n)tiA',u'kontia'),
			(u'pp',u'(.*p)piA',u'oppia'),
			(u'kk',u'(.*k)kiA',u'loikkia'),
			(u'tt',u'(.*t)tiA',u'sättiä'),
			(u't',u'(.*)tiA',u'laatia'),
			(u'p',u'(.*)piA',u'kaapia'),
			(u'k>j',u'(.*)kiA',u'hylkiä'),
			(u'k>',u'(.*i)kiA',u'poikia'),
			(u'k>',u'(.*)kiA',u'loikkia')]),
	(u'moittia', u'sw', [(u'tt',u'(.*t)tiA',u'moittia')]),
	(u'voida', u'ws', [(u't',u'(.*)idA',u'voida')]),
	(u'kanavoida', u'ws', [(u't',u'(.*O)idA',u'kanavoida')]),
	(u'nuolaista', u'ws', [(None,u'(CAis)tA',u'nousta'),
			   (None,u'(.*CA)istA',u'nuolaista'),
			   (None,u'(.*C)istA',u'kalista'),
			   (None,u'(.*s)tA',u'nousta'),
			   (u'ng',u'(.*n)gAistA',u'rangaista')]),
	(u'katsella', u'ws', [(None,u'(.*el)lA',u'katsella'),
			(None,u'(.*eil)lA',u'katsella'),
			(None,u'(.*Vil)lA',u'arvailla'),
			(None,u'(.*il)lA',u'katsella'),
			(u'mm',u'(.*m)mellA',u'ommella'),
			(u'rr',u'(.*r)rellA',u'askarrella'),
			(u'nn',u'(.*n)nellA',u'pienennellä'),
			(u'll',u'(.*l)lellA',u'takellella'),
			(u'k',u'(.*k)ellA',u'nakella'),
			(u't',u'(.*t)ellA',u'aatella'),
			(u'p',u'(.*p)ellA',u'tapella'),
			(u'd',u'(.*)dellA',u'kohdella'),
			(u'>k',u'(.*)ellA',u'nakella')]),
	(u'arvailla', u'-', [(None,u'(.*Vi)llA',u'arvailla')]),
	(u'haravoida', u'ws', [(u't',u'(.*O)idA',u'haravoida')]),
	(u'valita', u'-', [(None,u'(.*i)tA',u'valita')]),
	(u'saneerata', u'-', [(None,u'(.*C)AtA',u'saneerata')]),
	(u'aleta', u'ws',  [(None,u'(.*CV)tA',u'aleta'),
	                    (u'mm',u'(.*m)metA',u'lämmetä'),
			(u't',u'(.*t)OtA',u'loitota'),
			(u'p',u'(.*p)AtA',u'hapata'),
			(u'p',u'(.*p)etA',u'suipeta'),
			(u'k',u'(.*k)etA',u'vaieta'),
			(u'd',u'(.*)detA',u'edetä'),
			(u'd',u'(.*)dOtA',u'leudota'),
			(u'd',u'(.*)dAtA',u'mädätä'),
			(u'v',u'(.*)vetA',u'kaveta'),
			(u'>k',u'(.*)OtA',u'ulota'),
			(u'>k',u'(.*)etA',u'vaieta')]),
	(u'haluta', u'ws', [(None,u'(.*C)itA',u'selvitä'),
			(None,u'(.*U)tA',u'haluta'),
			(u'll',u'(.*l)litA',u'hellitä'),
			(u'mm',u'(.*m)mitA',u'lämmitä'),
			(u'p',u'(.*p)UtA',u'silputa'),
			(u'v',u'(.*)vUtA',u'vivuta')]),
	(u'juoruta', u'ws', [(None,u'(.*U)tA',u'juoruta'),
			(u'mm',u'(.*m)mUtA',u'kummuta'),
			(u't',u'(.*t)UtA',u'luututa'),
			(u'p',u'(.*p)UtA',u'ryöpytä'),
			(u'v',u'(.*)vUtA',u'kavuta')]),
	(u'salata', u'ws', [(None,u'(.*)AtA',u'salata'),
	                    (u'ng',u'(.*n)gAtA',u'hangata'),
			(u'mm',u'(.*m)mAtA',u'kammata'),
			(u'rr',u'(.*r)rAtA',u'kerrata'),
			(u'nn',u'(.*n)nAtA',u'suunnata'),
			(u'll',u'(.*l)lAtA',u'vallata'),
			(u'v',u'(.*)vAtA',u'kelvata'),
			(u't',u'(.*t)AtA',u'kuitata'),
			(u'd',u'(.*)dAtA',u'ladata'),
			(u'k',u'(.*k)AtA',u'pakata'),
			(u'p',u'(.*p)AtA',u'pompata'),
			(u'>k',u'(.*)AtA',u'taata')]),
	(u'katketa', u'ws', [(None,u'(.*e)tA',u'katketa'),
	                     (u'mm',u'(.*m)metA',u'kammeta'),
			 (u'ng',u'(.*n)getA',u'langeta'),
			 (u't',u'(.*t)OtA',u'lotota'),
			 (u'k',u'(.*k)etA',u'poiketa'),
			 (u'v',u'(.*)vetA',u'ruveta'),
			 (u'd',u'(.*)detA',u'todeta'),
			 (u'j>k',u'(.*)jetA',u'lohjeta'),
			 (u'>k',u'(.*)OtA',u'saota'),
			 (u'>k',u'(.*)etA',u'poiketa')]),
	(u'kohota', u'ws', [(None,u'(.*O)tA',u'kohota'),
	                    (u'rr',u'(.*r)rOtA',u'irrota'),
			(u'mm',u'(.*m)mOtA',u'kimmota'),
			(u'ng',u'(.*n)gOtA',u'lingota'),
			(u't',u'(.*t)OtA',u'netota'),
			(u'p',u'(.*p)OtA',u'upota'),
			(u'v',u'(.*r)vOtA',u'turvota'),
			(u'k',u'(.*Vk)OtA',u'laota'),
			(u'd',u'(.*)dOtA',u'kadota'),
			(u'>k',u'(.*)OtA',u'laota')]),
	(u'kihistä', u'-', [(None,u'(.*C)istA',u'kihistä')])
	]

flagmap = [(u'inen', 3), (u'ei_inen', 4), (u'ei_voikko', 5), (u'ei_sukija', 6), (u'ei_ys', 7),
	 (u'ei_ysa', 8), (u'ei_ysj', 9), (u'siv', 17), (u'ei_lAinen', 27),
	 (u'ysj', 29), (u'ei_mAinen', 30), (u'murre', 2), (u'yt', 31), (u'ei_vertm', 32),
	 (u'ei_yks', 37), (u'ei_voikko', 40)]

histmap = [(u'antautua', u'kaatua'), (u'banaali', u'paperi'), (u'kirjoitella', 'aatella'),
	 (u'kantaja', u'apaja'), (u'pasuuna', u'peruna'), (u'tuomi', u'niemi')]

def match_re(string, pattern):
	pattern = pattern.replace(u'V', u'(?:a|e|i|o|u|y|ä|ö|é)')
	pattern = pattern.replace(u'C', u'(?:b|c|d|f|g|h|j|k|l|m|n|p|q|r|s|t|v|w|x|y|z|š|ž)')
	pattern = pattern.replace(u'A', u'(?:a|ä)')
	pattern = pattern.replace(u'O', u'(?:o|ö)')
	pattern = pattern.replace(u'U', u'(?:u|y)')
	match = re.compile(u'^' + pattern + u'$', re.IGNORECASE).match(string)
	if match == None: return None
	else: return match.group(1)
