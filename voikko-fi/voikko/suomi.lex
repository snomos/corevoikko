# Suomi-malaga, suomen kielen muoto-opin kuvaus.
#
# Tekijänoikeus © 2006-2009 Hannu Väisänen (Etunimi.Sukunimi@joensuu.fi)
#                 2006-2010 Harri Pitkänen (hatapitk@iki.fi)
#
# Tämä ohjelma on vapaa; tätä ohjelmaa on sallittu levittää
# edelleen ja muuttaa GNU yleisen lisenssin (GPL lisenssin)
# ehtojen mukaan sellaisina kuin Free Software Foundation
# on ne julkaissut; joko Lisenssin version 2, tai (valinnan
# mukaan) minkä tahansa myöhemmän version mukaisesti.
#
# Tätä ohjelmaa levitetään siinä toivossa, että se olisi
# hyödyllinen, mutta ilman mitään takuuta; ilman edes
# hiljaista takuuta kaupallisesti hyväksyttävästä laadusta tai
# soveltuvuudesta tiettyyn tarkoitukseen. Katso GPL
# lisenssistä lisää yksityiskohtia.
#
# Tämän ohjelman mukana pitäisi tulla kopio GPL
# lisenssistä; jos näin ei ole, kirjoita osoitteeseen Free
# Software Foundation Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA 02110-1301, USA.
#
# Tämän ohjeman linkittäminen staattisesti tai dynaamisesti
# muihin moduuleihin on ohjelmaan perustuvan teoksen
# tekemistä, joka on siis GPL lisenssin ehtojen alainen.
#
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.  If not, write to the
# Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
# 02110-1301, USA.
#
# Linking this program statically or dynamically with other modules is
# making a combined work based on this program.  Thus, the terms and
# conditions of the GNU General Public License cover the whole
# combination.


# Karlsson 1983:
# Fred Karlsson: Suomen kielen äänne- ja muotorakenne.
# WSOY, Juva 1983
# ISBN 951-0-11633-5

define @yhdyssana := <nimisana, laatusana, tavuviiva>;

define @sijan_jatko := <tavuviiva, liitesana, loppu>;
define @sijan_jatko_ol := @sijan_jatko + <omistusliite>;


[alku: "t",    luokka: sijapääte, sija: nimentö_t, sijamuoto: nimentö,
               luku: monikko, äs: aä, jatko: @sijan_jatko];

[alku: "tka",  luokka: sijapääte, sija: nimentö_tkA, sijamuoto: nimentö,
               luku: monikko, äs: a, jatko: @sijan_jatko];
[alku: "tkä",  luokka: sijapääte, sija: nimentö_tkA, sijamuoto: nimentö,
               luku: monikko, äs: ä, jatko: @sijan_jatko];

[alku: "n",    luokka: sijapääte, sija: omanto_n, sijamuoto: omanto,
               luku: yksikkö, äs: aä,
               jatko: @sijan_jatko + @yhdyssana];

[alku: "nka",  luokka: sijapääte, sija: omanto_nkA, sijamuoto: omanto,
               luku: yksikkö, äs: a, jatko: @sijan_jatko];
[alku: "nkä",  luokka: sijapääte, sija: omanto_nkA, sijamuoto: omanto,
               luku: yksikkö, äs: ä, jatko: @sijan_jatko];



[alku: "en",    luokka: sijapääte, sija: omanto_en, sijamuoto: omanto, ei_kaksoispisteen_jälkeen: yes,
                luku: monikko, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "e",     luokka: sijapääte, sija: omanto_en, sijamuoto: omanto, ei_kaksoispisteen_jälkeen: yes,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "ien",   luokka: sijapääte, sija: omanto_ien, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "ie",    luokka: sijapääte, sija: omanto_ien, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "jen",   luokka: sijapääte, sija: omanto_jen, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "je",    luokka: sijapääte, sija: omanto_jen, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "in",    luokka: sijapääte, sija: omanto_in, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: @sijan_jatko + @yhdyssana];


[alku: "ten",   luokka: sijapääte, sija: omanto_ten, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "te",    luokka: sijapääte, sija: omanto_ten, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "iden",  luokka: sijapääte, sija: omanto_iT, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "ide",   luokka: sijapääte, sija: omanto_iT, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: <omistusliite>];
[alku: "itten", luokka: sijapääte, sija: omanto_iT, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "itte",  luokka: sijapääte, sija: omanto_iT, sijamuoto: omanto,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "idän",  luokka: sijapääte, sija: omanto_idän, sijamuoto: omanto,
                luku: monikko, äs: ä, jatko: @sijan_jatko];


[alku: "idät",  luokka: sijapääte, sija: kohdanto_idät, sijamuoto: kohdanto,
                luku: monikko, äs: ä, jatko: @sijan_jatko];

[alku: "t",     luokka: sijapääte, sija: kohdanto_t, sijamuoto: kohdanto,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko];


[alku: "a",     luokka: sijapääte, sija: osanto_A, sijamuoto: osanto,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "ä",     luokka: sijapääte, sija: osanto_A, sijamuoto: osanto,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "aa",    luokka: sijapääte, sija: osanto_AA, sijamuoto: osanto,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "ää",    luokka: sijapääte, sija: osanto_AA, sijamuoto: osanto,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "ta",    luokka: sijapääte, sija: osanto_tA, sijamuoto: osanto,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "tä",    luokka: sijapääte, sija: osanto_tA, sijamuoto: osanto,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "tta",   luokka: sijapääte, sija: osanto_ttA, sijamuoto: osanto,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "ttä",   luokka: sijapääte, sija: osanto_ttA, sijamuoto: osanto,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "ita",   luokka: sijapääte, sija: osanto_itA, sijamuoto: osanto,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "itä",   luokka: sijapääte, sija: osanto_itA, sijamuoto: osanto,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];

[alku: "ia",    luokka: sijapääte, sija: osanto_iA, sijamuoto: osanto,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "iä",    luokka: sijapääte, sija: osanto_iA, sijamuoto: osanto,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];

[alku: "ja",    luokka: sijapääte, sija: osanto_jA, sijamuoto: osanto,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "jä",    luokka: sijapääte, sija: osanto_jA, sijamuoto: osanto,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];


[alku: "na",    luokka: sijapääte, sija: olento_nA, sijamuoto: olento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol - <tavuviiva>];
[alku: "nä",    luokka: sijapääte, sija: olento_nA, sijamuoto: olento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol - <tavuviiva>];


[alku: "ina",   luokka: sijapääte, sija: olento_inA, sijamuoto: olento,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "inä",   luokka: sijapääte, sija: olento_inA, sijamuoto: olento,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];


[alku: "ksi",   luokka: sijapääte, sija: tulento_ksi, sijamuoto: tulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko];
[alku: "kse",   luokka: sijapääte, sija: tulento_ksi, sijamuoto: tulento,
                luku: yksikkö, äs: aä, jatko: <omistusliite>];

[alku: "iksi",  luokka: sijapääte, sija: sija_monikko_1, sijamuoto: tulento,
                luku: monikko, äs: aä, jatko: @sijan_jatko];
[alku: "ikse",  luokka: sijapääte, sija: sija_monikko_1, sijamuoto: tulento,
                luku: monikko, äs: aä, jatko: <omistusliite>];


[alku: "ssa",   luokka: sijapääte, sija: sisäolento_ssA, sijamuoto: sisäolento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "ssä",   luokka: sijapääte, sija: sisäolento_ssA, sijamuoto: sisäolento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "issa",  luokka: sijapääte, sija: sija_monikko_1, sijamuoto: sisäolento,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "issä",  luokka: sijapääte, sija: sija_monikko_1, sijamuoto: sisäolento,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];


[alku: "sta",   luokka: sijapääte, sija: sisäolento_ssA, sijamuoto: sisäeronto,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "stä",   luokka: sijapääte, sija: sisäolento_ssA, sijamuoto: sisäeronto,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "ista",  luokka: sijapääte, sija: sija_monikko_1, sijamuoto: sisäeronto,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "istä",  luokka: sijapääte, sija: sija_monikko_1, sijamuoto: sisäeronto,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];


[alku: "an",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: a, jatko: @sijan_jatko];
[alku: "a",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: a, jatko: <omistusliite>];
[alku: "en",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: aä, jatko: @sijan_jatko];
[alku: "e",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: aä, jatko: <omistusliite>];
[alku: "in",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: aä, jatko: @sijan_jatko];
[alku: "i",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: aä, jatko: <omistusliite>];
[alku: "on",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: a, jatko: @sijan_jatko];
[alku: "o",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: a, jatko: <omistusliite>];
[alku: "un",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: a, jatko: @sijan_jatko];
[alku: "u",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: a, jatko: <omistusliite>];
[alku: "yn",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: ä, jatko: @sijan_jatko];
[alku: "y",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: ä, jatko: <omistusliite>];
[alku: "än",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: ä, jatko: @sijan_jatko];
[alku: "ä",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: ä, jatko: <omistusliite>];
[alku: "ön",   luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: ä, jatko: @sijan_jatko];
[alku: "ö",    luokka: sijapääte, sija: sisätulento_Vn, sijamuoto: sisätulento,
               luku: yksikkö, äs: ä, jatko: <omistusliite>];

[alku: "aan",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko];
[alku: "een",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko];
[alku: "iin",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko];
[alku: "oon",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko];
[alku: "uun",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko];
[alku: "yyn",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko];
[alku: "ään",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko];
[alku: "öön",   luokka: sijapääte, sija: sisätulento_VVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko];


[alku: "han",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko + @yhdyssana];
[alku: "ha",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: <omistusliite>];
[alku: "hen",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "he",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: <omistusliite>];
[alku: "hin",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko + @yhdyssana];
[alku: "hi",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: <omistusliite>];
[alku: "hon",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko + @yhdyssana];
[alku: "ho",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: <omistusliite>];
[alku: "hun",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko + @yhdyssana];
[alku: "hu",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: a, jatko: <omistusliite>];
[alku: "hyn",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko + @yhdyssana];
[alku: "hy",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: <omistusliite>];
[alku: "hän",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko + @yhdyssana];
[alku: "hä",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: <omistusliite>];
[alku: "hön",   luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko + @yhdyssana];
[alku: "hö",    luokka: sijapääte, sija: sisätulento_hVn, sijamuoto: sisätulento,
                luku: yksikkö, äs: ä, jatko: <omistusliite>];

[alku: "iin",  luokka: sijapääte, sija: sisätulento_iin, sijamuoto: sisätulento,
               luku: monikko, äs: aä, jatko: @sijan_jatko];
[alku: "ii",   luokka: sijapääte, sija: sisätulento_iin, sijamuoto: sisätulento,
               luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "ihin",  luokka: sijapääte, sija: sisätulento_ihin, sijamuoto: sisätulento,
                luku: monikko, äs: aä, jatko: @sijan_jatko];
[alku: "ihi",   luokka: sijapääte, sija: sisätulento_ihin, sijamuoto: sisätulento,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "seen",  luokka: sijapääte, sija: sisätulento_seen, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko];
[alku: "see",   luokka: sijapääte, sija: sisätulento_seen, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: <omistusliite>];

[alku: "isiin", luokka: sijapääte, sija: sisätulento_isiin, sijamuoto: sisätulento,
                luku: monikko, äs: aä, jatko: @sijan_jatko];
[alku: "isii",  luokka: sijapääte, sija: sisätulento_isiin, sijamuoto: sisätulento,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "sen",   luokka: sijapääte, sija: sisätulento_sen, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko, tiedot: <murre>]; # kaunihisen
[alku: "se",    luokka: sijapääte, sija: sisätulento_sen, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: <omistusliite>, tiedot: <murre>];

[alku: "isin",  luokka: sijapääte, sija: sisätulento_isin, sijamuoto: sisätulento,
                luku: monikko, äs: aä, jatko: @sijan_jatko];
[alku: "isi",   luokka: sijapääte, sija: sisätulento_isin, sijamuoto: sisätulento,
                luku: monikko, äs: aä, jatko: <omistusliite>];

[alku: "nne",   luokka: sijapääte, sija: sisätulento_nne, sijamuoto: sisätulento,
                luku: yksikkö, äs: aä, jatko: <liitesana, loppu>];

[alku: "lla",   luokka: sijapääte, sija: ulkopaikallissija_llA, sijamuoto: ulko_olento,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "llä",   luokka: sijapääte, sija: ulkopaikallissija_llA, sijamuoto: ulko_olento,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "illa",  luokka: sijapääte, sija: ulkopaikallissija_illA, sijamuoto: ulko_olento,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "illä",  luokka: sijapääte, sija: ulkopaikallissija_illA, sijamuoto: ulko_olento,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];


[alku: "lta",   luokka: sijapääte, sija: ulkopaikallissija_llA, sijamuoto: ulkoeronto,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "ltä",   luokka: sijapääte, sija: ulkopaikallissija_llA, sijamuoto: ulkoeronto,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "ilta",  luokka: sijapääte, sija: ulkopaikallissija_illA, sijamuoto: ulkoeronto,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "iltä",  luokka: sijapääte, sija: ulkopaikallissija_illA, sijamuoto: ulkoeronto,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];


[alku: "lle",   luokka: sijapääte, sija: ulkopaikallissija_llA, sijamuoto: ulkotulento,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko_ol];

[alku: "ille",  luokka: sijapääte, sija: ulkopaikallissija_illA, sijamuoto: ulkotulento,
                luku: monikko, äs: aä, jatko: @sijan_jatko_ol];


[alku: "tta",   luokka: sijapääte, sija: vajanto_ttA, sijamuoto: vajanto,
                luku: yksikkö, äs: a, jatko: @sijan_jatko_ol];
[alku: "ttä",   luokka: sijapääte, sija: vajanto_ttA, sijamuoto: vajanto,
                luku: yksikkö, äs: ä, jatko: @sijan_jatko_ol];

[alku: "itta",  luokka: sijapääte, sija: vajanto_ittA, sijamuoto: vajanto,
                luku: monikko, äs: a, jatko: @sijan_jatko_ol];
[alku: "ittä",  luokka: sijapääte, sija: vajanto_ittA, sijamuoto: vajanto,
                luku: monikko, äs: ä, jatko: @sijan_jatko_ol];


[alku: "ine",   luokka: sijapääte, sija: seuranto_ine, sijamuoto: seuranto,
                luku: monikko, äs: aä, jatko: <omistusliite, loppu>];

[alku: "n",     luokka: sijapääte, sija: keinonto_n, sijamuoto: keinonto,
                luku: yksikkö, äs: aä, jatko: @sijan_jatko];
[alku: "in",    luokka: sijapääte, sija: vajanto_ittA, sijamuoto: keinonto,
                luku: monikko, äs: aä, jatko: @sijan_jatko];

[alku: "sti",   luokka: sijapääte, sija: kerronto_sti, sijamuoto: kerronto_sti,
                äs: aä, jatko: <liitesana, loppu>];

[alku: "s",     luokka: sijapääte, sija: tulento_s, sijamuoto: tulento,
                luku: yksikkö, äs: aä, jatko: <liitesana, loppu>];



[alku: "ni",  luokka: omistusliite, omistusliite: omistusliite_1s, äs: aä, jatko: <>];
[alku: "si",  luokka: omistusliite, omistusliite: omistusliite_2s, äs: aä, jatko: <>];
[alku: "s",   luokka: omistusliite, omistusliite: omistusliite_2s, äs: aä, jatko: <>, tiedot: <murre>];
[alku: "nsa", luokka: omistusliite, omistusliite: omistusliite_3, äs: a,  jatko: <>];
[alku: "nsä", luokka: omistusliite, omistusliite: omistusliite_3, äs: ä,  jatko: <>];
[alku: "an",  luokka: omistusliite, omistusliite: omistusliite_3, äs: a,  jatko: <>];
[alku: "en",  luokka: omistusliite, omistusliite: omistusliite_3, äs: aä, jatko: <>];
[alku: "on",  luokka: omistusliite, omistusliite: omistusliite_3, äs: a,  jatko: <>];
[alku: "un",  luokka: omistusliite, omistusliite: omistusliite_3, äs: a,  jatko: <>];
[alku: "yn",  luokka: omistusliite, omistusliite: omistusliite_3, äs: ä,  jatko: <>];
[alku: "än",  luokka: omistusliite, omistusliite: omistusliite_3, äs: ä,  jatko: <>];
[alku: "ön",  luokka: omistusliite, omistusliite: omistusliite_3, äs: ä,  jatko: <>];
[alku: "mme", luokka: omistusliite, omistusliite: omistusliite_1p, äs: aä, jatko: <>];
[alku: "nne", luokka: omistusliite, omistusliite: omistusliite_2p, äs: aä, jatko: <>];


# Laatusanojen sekä teonsanojen laatutapojen voittoaste.
#
define @jatko_mpA := <omistusliite, osanto_A, osanto_tA, olento_nA, sisätulento_Vn>;
define @jatko_mmA := <omanto_n, tulento_ksi, sisäolento_ssA,
                      ulkopaikallissija_llA,
                      vajanto_ttA, kerronto_sti>;
define @jatko_mp := <omanto_ien, osanto_iA, olento_inA, sisätulento_iin, seuranto_ine>;
define @jatko_mm := <sija_monikko_1,
                     ulkopaikallissija_illA,
                     vajanto_ittA, johdin_UUs>;


[alku: "mpi", luokka: voittoaste, sija: nimentö, luku: yksikkö,
               äs: aä, jatko: @sana2 + <liitesana, loppu>];
[alku: "mpa", luokka: voittoaste, luku: yksikkö, äs: a, jatko: @jatko_mpA];
[alku: "mpä", luokka: voittoaste, luku: yksikkö, äs: ä, jatko: @jatko_mpA];
[alku: "mma", luokka: voittoaste, luku: yksikkö, äs: a, jatko: @jatko_mmA];
[alku: "mmä", luokka: voittoaste, luku: yksikkö, äs: ä, jatko: @jatko_mmA];

[alku: "mma", luokka: voittoaste, luku: monikko, äs: a, jatko: <nimentö_t>];
[alku: "mmä", luokka: voittoaste, luku: monikko, äs: ä, jatko: <nimentö_t>];
[alku: "mpa", luokka: voittoaste, luku: monikko, äs: a, jatko: <omanto_in>];
[alku: "mpä", luokka: voittoaste, luku: monikko, äs: ä, jatko: <omanto_in>];
[alku: "mp",  luokka: voittoaste, luku: monikko, äs: aä, jatko: @jatko_mp];
[alku: "mm",  luokka: voittoaste, luku: monikko, äs: aä, jatko: @jatko_mm];


# Laatusanojen sekä teonsanojen laatutapojen yliaste.
#
[alku: "in",   luokka: yliaste, sija: nimentö, luku: yksikkö,
               äs: aä, jatko: <osanto_tA, liitesana, loppu>];
[alku: "impa", luokka: yliaste, luku: yksikkö, äs: a, jatko: @jatko_mpA];
[alku: "impä", luokka: yliaste, luku: yksikkö, äs: ä, jatko: @jatko_mpA];
[alku: "imma", luokka: yliaste, luku: yksikkö, äs: a, jatko: @jatko_mmA];
[alku: "immä", luokka: yliaste, luku: yksikkö, äs: ä, jatko: @jatko_mmA];

[alku: "imma", luokka: yliaste, luku: monikko, äs: a, jatko: <nimentö_t>];
[alku: "immä", luokka: yliaste, luku: monikko, äs: ä, jatko: <nimentö_t>];
[alku: "impa", luokka: yliaste, luku: monikko, äs: a, jatko: <omanto_in>];
[alku: "impä", luokka: yliaste, luku: monikko, äs: ä, jatko: <omanto_in>];
[alku: "in",   luokka: yliaste, luku: monikko, äs: aä, jatko: <omanto_ten>];
[alku: "imp",  luokka: yliaste, luku: monikko, äs: aä, jatko: @jatko_mp];
[alku: "imm",  luokka: yliaste, luku: monikko, äs: aä, jatko: @jatko_mm];


# Karlsson 1983, s. 234,
#
[alku: "kin",       luokka: liitesana, fokus: kin, kielto: no, äs: aä, jatko: <loppu>];
[alku: "kaan",      luokka: liitesana, fokus: kaan, kielto: yes, äs: a, jatko: <loppu>];
[alku: "kään",      luokka: liitesana, fokus: kaan, kielto: yes, äs: ä, jatko: <loppu>];
[alku: "kaanhan",   luokka: liitesana, fokus: kaan, äs: a, jatko: <loppu>];
[alku: "käänhän",   luokka: liitesana, fokus: kaan, äs: ä, jatko: <loppu>];
[alku: "ko",        luokka: liitesana, kysymysliite: yes, kielto: no, äs: a, jatko: <loppu>];
[alku: "kö",        luokka: liitesana, kysymysliite: yes, kielto: no, äs: ä, jatko: <loppu>];
[alku: "kokaan",    luokka: liitesana, fokus: kaan, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "kökään",    luokka: liitesana, fokus: kaan, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "pa",        luokka: liitesana, kielto: no, äs: a, jatko: <loppu>];
[alku: "pä",        luokka: liitesana, kielto: no, äs: ä, jatko: <loppu>];
[alku: "han",       luokka: liitesana, kielto: no, äs: a, jatko: <loppu>];
[alku: "hän",       luokka: liitesana, kielto: no, äs: ä, jatko: <loppu>];
[alku: "kohan",     luokka: liitesana, kysymysliite: yes, kielto: no, äs: a, jatko: <loppu>];
[alku: "köhän",     luokka: liitesana, kysymysliite: yes, kielto: no, äs: ä, jatko: <loppu>];
[alku: "pahan",     luokka: liitesana, kielto: no, äs: a, jatko: <loppu>];
[alku: "pähän",     luokka: liitesana, kielto: no, äs: ä, jatko: <loppu>];
[alku: "kos",       luokka: liitesana, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "kös",       luokka: liitesana, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "pas",       luokka: liitesana, kielto: no, äs: a, jatko: <loppu>];
[alku: "päs",       luokka: liitesana, kielto: no, äs: ä, jatko: <loppu>];
[alku: "kinko",     luokka: liitesana, fokus: kin, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "kinkö",     luokka: liitesana, fokus: kin, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "kaanko",    luokka: liitesana, fokus: kaan, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "käänkö",    luokka: liitesana, fokus: kaan, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "kinhan",    luokka: liitesana, fokus: kin, kielto: no, äs: a, jatko: <loppu>];
[alku: "kinhän",    luokka: liitesana, fokus: kin, kielto: no, äs: ä, jatko: <loppu>];
[alku: "kinkohan",  luokka: liitesana, fokus: kin, kysymysliite: yes, kielto: no, äs: a, jatko: <loppu>];
[alku: "kinköhän",  luokka: liitesana, fokus: kin, kysymysliite: yes, kielto: no, äs: ä, jatko: <loppu>];
[alku: "kinkos",    luokka: liitesana, fokus: kin, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "kinkös",    luokka: liitesana, fokus: kin, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "kaankohan", luokka: liitesana, fokus: kaan, kysymysliite: yes, kielto: no, äs: a, jatko: <loppu>];
[alku: "käänköhän", luokka: liitesana, fokus: kaan, kysymysliite: yes, kielto: no, äs: ä, jatko: <loppu>];
[alku: "kaankos",   luokka: liitesana, fokus: kaan, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "käänkös",   luokka: liitesana, fokus: kaan, kysymysliite: yes, äs: ä, jatko: <loppu>];

[alku: "ko",        luokka: kieltosanan_liitesana, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "kö",        luokka: kieltosanan_liitesana, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "pa",        luokka: kieltosanan_liitesana, äs: a, jatko: <loppu>];
[alku: "pä",        luokka: kieltosanan_liitesana, äs: ä, jatko: <loppu>];
[alku: "han",       luokka: kieltosanan_liitesana, äs: a, jatko: <loppu>];
[alku: "hän",       luokka: kieltosanan_liitesana, äs: ä, jatko: <loppu>];
[alku: "kohan",     luokka: kieltosanan_liitesana, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "köhän",     luokka: kieltosanan_liitesana, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "pahan",     luokka: kieltosanan_liitesana, äs: a, jatko: <loppu>];
[alku: "pähän",     luokka: kieltosanan_liitesana, äs: ä, jatko: <loppu>];
[alku: "kos",       luokka: kieltosanan_liitesana, kysymysliite: yes, äs: a, jatko: <loppu>];
[alku: "kös",       luokka: kieltosanan_liitesana, kysymysliite: yes, äs: ä, jatko: <loppu>];
[alku: "pas",       luokka: kieltosanan_liitesana, äs: a, jatko: <loppu>];
[alku: "päs",       luokka: kieltosanan_liitesana, äs: ä, jatko: <loppu>];
[alku: "kä",        luokka: kieltosanan_liitesana, äs: ä, jatko: <loppu>]; # Ei+kä, älä+kä.

[alku: "pi", luokka: liitesana_pi, äs: aä, jatko: <liitesana, loppu>]; # Tulee+pi.

# Teonsanojen tositavan kestämän tekijäpäätteet.
#
[alku: "n",   luokka: kestämän_tekijäpääte_heikko, luku: yksikkö, tekijä: tekijä_1,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: aä, jatko: <liitesana, loppu>];
[alku: "t",   luokka: kestämän_tekijäpääte_heikko, luku: yksikkö, tekijä: tekijä_2,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: aä, jatko: <liitesana, loppu>];


define @jatko_y3 := <liitesana, liitesana_pi, loppu>;

[alku: "a",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: a, jatko: @jatko_y3];
[alku: "e",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: aä, jatko: @jatko_y3];
[alku: "i",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: aä, jatko: @jatko_y3];
[alku: "o",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: a, jatko: @jatko_y3];
[alku: "u",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: a, jatko: @jatko_y3];
[alku: "y",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: ä, jatko: @jatko_y3];
[alku: "ä",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: ä, jatko: @jatko_y3];
[alku: "ö",   luokka: kestämän_tekijäpääte_y3, luku: yksikkö, tekijä: tekijä_3, kielto: no,
              tapaluokka: tositapa, aikamuoto: kestämä, äs: ä, jatko: @jatko_y3];


[alku: "mme", luokka: kestämän_tekijäpääte_heikko, luku: monikko, tekijä: tekijä_1, äs: aä,
              tapaluokka: tositapa, aikamuoto: kestämä, jatko: <liitesana, loppu>];
[alku: "tte", luokka: kestämän_tekijäpääte_heikko, luku: monikko, tekijä: tekijä_2, äs: aä,
              tapaluokka: tositapa, aikamuoto: kestämä, jatko: <liitesana, loppu>];
[alku: "vat", luokka: kestämän_tekijäpääte_m3, luku: monikko, tekijä: tekijä_3, äs: a,
              tapaluokka: tositapa, aikamuoto: kestämä, jatko: <liitesana, loppu>];
[alku: "vät", luokka: kestämän_tekijäpääte_m3, luku: monikko, tekijä: tekijä_3, äs: ä,
              tapaluokka: tositapa, aikamuoto: kestämä, jatko: <liitesana, loppu>];


# Teonsanojen tositavan kertoman tunnus (i) ja tekijäpääte:
# sano+in, sano+it, sano+i, sano+imme, sano+itte, sano+ivat.
#
# Yhdistin kertoman tunnuksen ja tekijäpäätteen astevaihtelun vuoksi:
# asetu+in, asetu+it, asettu+i, asetu+imme, asetu+itte, asettu+ivat.
#
[alku: "in",   luokka: kertoman_tekijäpääte_heikko, luku: yksikkö, tekijä: tekijä_1, äs: aä,
               tapaluokka: tositapa, aikamuoto: kertoma, jatko: <liitesana, loppu>];
[alku: "it",   luokka: kertoman_tekijäpääte_heikko, luku: yksikkö, tekijä: tekijä_2, äs: aä,
               tapaluokka: tositapa, aikamuoto: kertoma, jatko: <liitesana, loppu>];
[alku: "i",    luokka: kertoman_tekijäpääte_vahva, luku: yksikkö, tekijä: tekijä_3, äs: aä,
               tapaluokka: tositapa, aikamuoto: kertoma, jatko: <liitesana, loppu>];

[alku: "imme", luokka: kertoman_tekijäpääte_heikko, luku: monikko, tekijä: tekijä_1, äs: aä,
               tapaluokka: tositapa, aikamuoto: kertoma, jatko: <liitesana, loppu>];
[alku: "itte", luokka: kertoman_tekijäpääte_heikko, luku: monikko, tekijä: tekijä_2, äs: aä,
               tapaluokka: tositapa, aikamuoto: kertoma, jatko: <liitesana, loppu>];
[alku: "ivat", luokka: kertoman_tekijäpääte_vahva, luku: monikko, tekijä: tekijä_3, äs: a,
               tapaluokka: tositapa, aikamuoto: kertoma, jatko: <liitesana, loppu>];
[alku: "ivät", luokka: kertoman_tekijäpääte_vahva, luku: monikko, tekijä: tekijä_3, äs: ä,
               tapaluokka: tositapa, aikamuoto: kertoma, jatko: <liitesana, loppu>];


[alku: "da", luokka: tositavan_kestämä_dAAn, tekijä: tekijä_4, kielto: yes, äs: a,  # Ei voi+da.
             jatko: <liitesana, loppu>,
             tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "dä", luokka: tositavan_kestämä_dAAn, tekijä: tekijä_4, kielto: yes, äs: ä,
             jatko: <liitesana, loppu>,
             tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "daan", luokka: tositavan_kestämä_dAAn, tekijä: tekijä_4, äs: a,  # Voi+daan.
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "dään", luokka: tositavan_kestämä_dAAn, tekijä: tekijä_4, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "la",   luokka: tositavan_kestämä_lAAn, tekijä: tekijä_4, kielto: yes, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "lä",   luokka: tositavan_kestämä_lAAn, tekijä: tekijä_4, kielto: yes, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "laan", luokka: tositavan_kestämä_lAAn, tekijä: tekijä_4, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "lään", luokka: tositavan_kestämä_lAAn, tekijä: tekijä_4, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "na",   luokka: tositavan_kestämä_nAAn, tekijä: tekijä_4, kielto: yes, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "nä",   luokka: tositavan_kestämä_nAAn, tekijä: tekijä_4, kielto: yes, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "naan", luokka: tositavan_kestämä_nAAn, tekijä: tekijä_4, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "nään", luokka: tositavan_kestämä_nAAn, tekijä: tekijä_4, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "ra",   luokka: tositavan_kestämä_rAAn, tekijä: tekijä_4, kielto: yes, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "rä",   luokka: tositavan_kestämä_rAAn, tekijä: tekijä_4, kielto: yes, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "raan", luokka: tositavan_kestämä_rAAn, tekijä: tekijä_4, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "rään", luokka: tositavan_kestämä_rAAn, tekijä: tekijä_4, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "ta",   luokka: tositavan_kestämä_tAAn, tekijä: tekijä_4, kielto: yes, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "tä",   luokka: tositavan_kestämä_tAAn, tekijä: tekijä_4, kielto: yes, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];

[alku: "taan", luokka: tositavan_kestämä_tAAn, tekijä: tekijä_4, kielto: no, äs: a,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];
[alku: "tään", luokka: tositavan_kestämä_tAAn, tekijä: tekijä_4, kielto: no, äs: ä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kestämä];


[alku: "ttiin", luokka: tositavan_kertoma_ttiin, tekijä: tekijä_4, äs: aä,
                jatko: <liitesana, loppu>,
                tapaluokka: tositapa, aikamuoto: kertoma];

[alku: "tiin", luokka: tositavan_kertoma_tiin, tekijä: tekijä_4, äs: aä,
               jatko: <liitesana, loppu>,
               tapaluokka: tositapa, aikamuoto: kertoma];


# Ehtotapa. Olen yhdistänyt ehtotavan tunnuksen (isi) ja tekijäpäätteen.
#
[alku: "isin",   luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_1, jatko: <liitesana, loppu>, kielto: no];
[alku: "isit",   luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_2, jatko: <liitesana, loppu>, kielto: no];
[alku: "isi",    luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_3, jatko: <liitesana, loppu>, kielto: molemmat];
[alku: "is",     luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_3, jatko: <liitesana, loppu>, tiedot: <murre>];
[alku: "isimme", luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_1, jatko: <liitesana, loppu>, kielto: no];
[alku: "isitte", luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_2, jatko: <liitesana, loppu>, kielto: no];
[alku: "isivat", luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: a, luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>, kielto: no];
[alku: "isivät", luokka: ehtotapa, tapaluokka: ehtotapa, aikamuoto: kestämä,
                 äs: ä, luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>, kielto: no];

[alku: "ttaisi",   luokka: ehtotapa_ttA, tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: a, tekijä: tekijä_4, kielto: yes, jatko: <liitesana, loppu>];
[alku: "ttäisi",   luokka: ehtotapa_ttA, tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: ä, tekijä: tekijä_4, kielto: yes, jatko: <liitesana, loppu>];
[alku: "ttaisiin", luokka: ehtotapa_ttA, tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: a, tekijä: tekijä_4, kielto: no, jatko: <liitesana, loppu>];
[alku: "ttäisiin", luokka: ehtotapa_ttA, tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: ä, tekijä: tekijä_4, kielto: no, jatko: <liitesana, loppu>];
[alku: "taisi",    luokka: ehtotapa_tA, tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: a, tekijä: tekijä_4, kielto: yes, jatko: <liitesana, loppu>];
[alku: "täisi",    luokka: ehtotapa_tA, tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: ä, tekijä: tekijä_4, kielto: yes, jatko: <liitesana, loppu>];
[alku: "taisiin",  luokka: ehtotapa_tA,  tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: a, tekijä: tekijä_4, kielto: no, jatko: <liitesana, loppu>];
[alku: "täisiin",  luokka: ehtotapa_tA,  tapaluokka: ehtotapa, aikamuoto: kestämä,
                   äs: ä, tekijä: tekijä_4, kielto: no, jatko: <liitesana, loppu>];


# Mahtotapa.
#
[alku: "len",    luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "let",    luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "lee",    luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "lemme",  luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "lette",  luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "levat",  luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: a,    luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "levät",  luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: ä,    luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>];

[alku: "le",     luokka: mahtotapa_le, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                 äs: aä, jatko: <liitesana, loppu>];

[alku: "nen",    luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "net",    luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "nee",    luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "nemme",  luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "nette",  luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "nevat",  luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: a,    luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "nevät",  luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: ä,    luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>];

[alku: "ne",     luokka: mahtotapa_ne, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                 äs: aä, jatko: <liitesana, loppu>];

[alku: "ren",    luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "ret",    luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "ree",    luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "remme",  luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "rette",  luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "revat",  luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: a,    luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "revät",  luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: ä,  jatko: <liitesana, loppu>];

[alku: "re",     luokka: mahtotapa_re, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                 äs: aä, jatko: <liitesana, loppu>];

[alku: "sen",    luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "set",    luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "see",    luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: yksikkö, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "semme",  luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_1, jatko: <liitesana, loppu>];
[alku: "sette",  luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: aä, luku: monikko, tekijä: tekijä_2, jatko: <liitesana, loppu>];
[alku: "sevat",  luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: a,  luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>];
[alku: "sevät",  luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä,
                 äs: ä,  luku: monikko, tekijä: tekijä_3, jatko: <liitesana, loppu>];

[alku: "se",     luokka: mahtotapa_se, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                 äs: aä, jatko: <liitesana, loppu>];


[alku: "ttane",   luokka: mahtotapa_ttA, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                  äs: a, tekijä: tekijä_4, jatko: <liitesana, loppu>];
[alku: "ttäne",   luokka: mahtotapa_ttA, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                  äs: ä, tekijä: tekijä_4, jatko: <liitesana, loppu>];
[alku: "ttaneen", luokka: mahtotapa_ttA, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: no,
                  äs: a, tekijä: tekijä_4, jatko: <liitesana, loppu>];
[alku: "ttäneen", luokka: mahtotapa_ttA, tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: no,
                  äs: ä, tekijä: tekijä_4, jatko: <liitesana, loppu>];
[alku: "tane",    luokka: mahtotapa_tA,  tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                  äs: a, tekijä: tekijä_4, jatko: <liitesana, loppu>];
[alku: "täne",    luokka: mahtotapa_tA,  tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: yes,
                  äs: ä, tekijä: tekijä_4, jatko: <liitesana, loppu>];
[alku: "taneen",  luokka: mahtotapa_tA,  tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: no,
                  äs: a, tekijä: tekijä_4, jatko: <liitesana, loppu>];
[alku: "täneen",  luokka: mahtotapa_tA,  tapaluokka: mahtotapa, aikamuoto: kestämä, kielto: no,
                  äs: ä, tekijä: tekijä_4, jatko: <liitesana, loppu>];



# Teonsanojen käskytavan (punokoon) henkilöpäätteet.
#
[alku: "koon",   luokka: käskytapa, luku: yksikkö, tekijä: tekijä_3, äs: a, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "köön",   luokka: käskytapa, luku: yksikkö, tekijä: tekijä_3, äs: ä, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "kaamme", luokka: käskytapa, luku: monikko, tekijä: tekijä_1, äs: a, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "käämme", luokka: käskytapa, luku: monikko, tekijä: tekijä_1, äs: ä, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "kaa",    luokka: käskytapa, luku: monikko, tekijä: tekijä_2, äs: a, kielto: no,
                 jatko: <liitesana, liitesana_s, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "kaatte", luokka: käskytapa, luku: monikko, tekijä: tekijä_2, äs: a, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "kää",    luokka: käskytapa, luku: monikko, tekijä: tekijä_2, äs: ä, kielto: no,
                 jatko: <liitesana, liitesana_s, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "käätte", luokka: käskytapa, luku: monikko, tekijä: tekijä_2, äs: ä, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "koot",   luokka: käskytapa, luku: monikko, tekijä: tekijä_3, äs: a, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "kööt",   luokka: käskytapa, luku: monikko, tekijä: tekijä_3, äs: ä, kielto: no,
                 jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];

[alku: "ttakoon", luokka: käskytapa_ttA, tekijä: tekijä_4, äs: a, kielto: no,
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "ttäköön", luokka: käskytapa_ttA, tekijä: tekijä_4, äs: ä, kielto: no,
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];

[alku: "ttako",   luokka: käskytapa_ttA, tekijä: tekijä_4, äs: a, kielto: yes, # Punoa, älköön puno+ttako.
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "ttäkö",   luokka: käskytapa_ttA, tekijä: tekijä_4, äs: ä, kielto: yes,
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];

[alku: "takoon",  luokka: käskytapa_tA, tekijä: tekijä_4, äs: a, kielto: no,
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "täköön",  luokka: käskytapa_tA, tekijä: tekijä_4, äs: ä, kielto: no,
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];

[alku: "tako",    luokka: käskytapa_tA, tekijä: tekijä_4, äs: a, kielto: yes, # Juosta, älköön juos+tako.
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];
[alku: "täkö",    luokka: käskytapa_tA, tekijä: tekijä_4, äs: ä, kielto: yes,
                  jatko: <liitesana, loppu>, tapaluokka: käskytapa, aikamuoto: kestämä];

[alku: "ko", luokka: käskytapa, äs: a, jatko: <loppu>, tapaluokka: käskytapa, aikamuoto: kestämä, kielto: yes]; # älköön olko
[alku: "kö", luokka: käskytapa, äs: ä, jatko: <loppu>, tapaluokka: käskytapa, aikamuoto: kestämä, kielto: yes];


# Ensimmäinen nimitapa.
#
define @nimitapa_1_jatko := <nimitapa_1_pitkä, liitesana, loppu>;

[alku: "a",  luokka: nimitapa_1_A,  tapaluokka: nimitapa_1, äs: a, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "ä",  luokka: nimitapa_1_A,  tapaluokka: nimitapa_1, äs: ä, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "da", luokka: nimitapa_1_dA, tapaluokka: nimitapa_1, äs: a, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "dä", luokka: nimitapa_1_dA, tapaluokka: nimitapa_1, äs: ä, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "la", luokka: nimitapa_1_lA, tapaluokka: nimitapa_1, äs: a, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "lä", luokka: nimitapa_1_lA, tapaluokka: nimitapa_1, äs: ä, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "na", luokka: nimitapa_1_nA, tapaluokka: nimitapa_1, äs: a, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "nä", luokka: nimitapa_1_nA, tapaluokka: nimitapa_1, äs: ä, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "ra", luokka: nimitapa_1_rA, tapaluokka: nimitapa_1, äs: a, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "rä", luokka: nimitapa_1_rA, tapaluokka: nimitapa_1, äs: ä, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "ta", luokka: nimitapa_1_tA, tapaluokka: nimitapa_1, äs: a, kielto: molemmat, jatko: @nimitapa_1_jatko];
[alku: "tä", luokka: nimitapa_1_tA, tapaluokka: nimitapa_1, äs: ä, kielto: molemmat, jatko: @nimitapa_1_jatko];


# Punoa+kse+ni
[alku: "kse", luokka: nimitapa_1_pitkä, tapaluokka: nimitapa_1, äs: aä, jatko: <omistusliite>];


# Toinen nimitapa: puno+essa, puno+en, puno+ttaessa.
#
[alku: "essa", luokka: nimitapa_2, tapaluokka: nimitapa_2, sija: sisäolento_ssA,
               äs: a, jatko: <omistusliite, liitesana, loppu>];
[alku: "essä", luokka: nimitapa_2, tapaluokka: nimitapa_2, sija: sisäolento_ssA,
               äs: ä, jatko: <omistusliite, liitesana, loppu>];
[alku: "en",   luokka: nimitapa_2, tapaluokka: nimitapa_2, sija: keinonto_n,
               äs: aä, jatko: <liitesana, loppu>];

[alku: "ttaessa", luokka: nimitapa_2_ttA, tapaluokka: nimitapa_2, äs: a, jatko: <liitesana, loppu>];
[alku: "ttäessä", luokka: nimitapa_2_ttA, tapaluokka: nimitapa_2, äs: ä, jatko: <liitesana, loppu>];
[alku: "taessa",  luokka: nimitapa_2_tA,  tapaluokka: nimitapa_2, äs: a, jatko: <liitesana, loppu>];
[alku: "täessä",  luokka: nimitapa_2_tA,  tapaluokka: nimitapa_2, äs: ä, jatko: <liitesana, loppu>];

# Murteissa.
[alku: "ttaissa", luokka: nimitapa_2_ttA, tapaluokka: nimitapa_2, äs: a, jatko: <liitesana, loppu>, tiedot: <murre>];
[alku: "ttäissä", luokka: nimitapa_2_ttA, tapaluokka: nimitapa_2, äs: ä, jatko: <liitesana, loppu>, tiedot: <murre>];
[alku: "taissa",  luokka: nimitapa_2_tA,  tapaluokka: nimitapa_2, äs: a, jatko: <liitesana, loppu>, tiedot: <murre>];
[alku: "täissä",  luokka: nimitapa_2_tA,  tapaluokka: nimitapa_2, äs: ä, jatko: <liitesana, loppu>, tiedot: <murre>];


# Kolmas nimitapa.
#
[alku: "massa", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: sisäolento_ssA,
                sijamuoto: sisäolento,
                luku: yksikkö, äs: a, jatko: <liitesana, loppu>];
[alku: "mässä", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: sisäolento_ssA,
                sijamuoto: sisäolento,
                luku: yksikkö, äs: ä, jatko: <liitesana, loppu>];

[alku: "masta", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: sisäolento_ssA,
                sijamuoto: sisäeronto,
                luku: yksikkö, äs: a, jatko: <liitesana, loppu>];
[alku: "mästä", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: sisäolento_ssA,
                sijamuoto: sisäeronto,
                luku: yksikkö, äs: ä, jatko: <liitesana, loppu>];

[alku: "maan",  luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: sisätulento_Vn,
                luku: yksikkö, sijamuoto: sisätulento, äs: a, jatko: <liitesana, loppu>];
[alku: "mään",  luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: sisätulento_Vn,
                luku: yksikkö, sijamuoto: sisätulento, äs: ä, jatko: <liitesana, loppu>];

[alku: "malla", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: ulkopaikallissija_llA,
                luku: yksikkö, sijamuoto: ulko_olento, äs: a, jatko: <liitesana, loppu>];
[alku: "mällä", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: ulkopaikallissija_llA,
                luku: yksikkö, sijamuoto: ulko_olento, äs: ä, jatko: <liitesana, loppu>];

[alku: "matta", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: vajanto_ttA,
                luku: yksikkö, sijamuoto: vajanto, äs: a, jatko: <liitesana, loppu>];
[alku: "mättä", luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: vajanto_ttA,
                luku: yksikkö, sijamuoto: vajanto, äs: ä, jatko: <liitesana, loppu>];

[alku: "man",   luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: keinonto_n,
                luku: yksikkö, sijamuoto: keinonto, äs: a, jatko: <liitesana, loppu>];
[alku: "män",   luokka: nimitapa_3, tapaluokka: nimitapa_3, sija: keinonto_n,
                luku: yksikkö, sijamuoto: keinonto, äs: ä, jatko: <liitesana, loppu>];

[alku: "ttaman", luokka: nimitapa_3_ttA, tapaluokka: nimitapa_3,
                 äs: a, jatko: <liitesana, loppu>];
[alku: "ttämän", luokka: nimitapa_3_ttA, tapaluokka: nimitapa_3,
                 äs: ä, jatko: <liitesana, loppu>];
[alku: "taman",  luokka: nimitapa_3_tA,  tapaluokka: nimitapa_3,
                 äs: a, jatko: <liitesana, loppu>];
[alku: "tämän",  luokka: nimitapa_3_tA,  tapaluokka: nimitapa_3,
                 äs: ä, jatko: <liitesana, loppu>];


define @jatko_se := <omistusliite, omanto_n,
                     olento_nA, tulento_ksi, 
                     sisäolento_ssA, sisätulento_Vn,
                     ulkopaikallissija_llA,
                     vajanto_ttA, nimentö_t>;
define @jatko_s := <osanto_tA, omanto_ien, omanto_ten,
                    osanto_iA, olento_inA, sija_monikko_1, 
                    sisätulento_iin,
                    ulkopaikallissija_illA,
                    vajanto_ittA, seuranto_ine> + @yhdyssana;

# Neljäs nimitapa: puno+minen, puno+mise+n, puno+mis+ia.
#
[alku: "minen", luokka: nimitapa_45, tapaluokka: nimitapa_4, äs: aä, perusmuoto: "minen", jatko: <liitesana, loppu>];
[alku: "mise",  luokka: nimitapa_45, tapaluokka: nimitapa_4, äs: aä, perusmuoto: "minen", jatko: @jatko_se];
[alku: "mis",   luokka: nimitapa_45, tapaluokka: nimitapa_4, äs: aä, perusmuoto: "minen", jatko: @jatko_s];


# Viides nimitapa: puhu+maisillaan, teke+mäisillään.
#
[alku: "maisilla", luokka: nimitapa_45, tapaluokka: nimitapa_5, äs: a, perusmuoto: "maisilla", jatko: <omistusliite>];
[alku: "mäisillä", luokka: nimitapa_45, tapaluokka: nimitapa_5, äs: ä, perusmuoto: "mäisillä", jatko: <omistusliite>];

define @jatko_vE1 :=
       <omanto_n, osanto_A, olento_nA, tulento_ksi,
        sisäolento_ssA, sisätulento_Vn,
        ulkopaikallissija_llA,
        vajanto_ttA, kerronto_sti, omistusliite, liitesana,
        nimentö_t, omanto_in, loppu> + @yhdyssana;

define @jatko_vE2 := <voittoaste>;

# Ensimmäinen laatutapa: punova, punovia, punottava, punottavia.
#
define @jatko_vA := @jatko_vE1 + @jatko_vE2 - <nimisana>;

define @jatko_v :=
       <omanto_ien,
        osanto_iA, olento_inA, sija_monikko_1,
        sisätulento_iin,
        ulkopaikallissija_illA,
        vajanto_ittA, seuranto_ine, yliaste>;

[perusmuoto: "va", alku: "v", luokka: johdin_vA, jatko: <asema>, äs: a];
[perusmuoto: "vä", alku: "v", luokka: johdin_vA, jatko: <asema>, äs: ä];
[alku: "v",  luokka: johdin_vA, äs: a, jatko: @jatko_v, perusmuoto: "va"];
[alku: "v",  luokka: johdin_vA, äs: ä, jatko: @jatko_v, perusmuoto: "vä"];

[alku: "va", luokka: johdin_vE, äs: a, jatko: @jatko_vE1];
[alku: "vä", luokka: johdin_vE, äs: ä, jatko: @jatko_vE1];
[alku: "ve", luokka: johdin_vE, äs: aä, jatko: @jatko_vE2];
[alku: "v",  luokka: johdin_vE, äs: a, jatko: @jatko_v, perusmuoto: "va"];
[alku: "v",  luokka: johdin_vE, äs: ä, jatko: @jatko_v, perusmuoto: "vä"];

[alku: "vuu", luokka: johdin_vE, jluokka: nimisana, äs: a, jatko: <kalleus>, perusmuoto: "vuus"];
[alku: "vyy", luokka: johdin_vE, jluokka: nimisana, äs: ä, jatko: <kalleus>, perusmuoto: "vyys"];


[alku: "vai", luokka: johdin_vA, jluokka: nimi_laatusana, äs: a, jatko: <nainen>, perusmuoto: "vainen"];
[alku: "väi", luokka: johdin_vA, jluokka: nimi_laatusana, äs: ä, jatko: <nainen>, perusmuoto: "väinen"];

[alku: "ttava", luokka: johdin_ttAvA, äs: a, jatko: @jatko_vA, perusmuoto: "ttava"];
[alku: "ttävä", luokka: johdin_ttAvA, äs: ä, jatko: @jatko_vA, perusmuoto: "ttävä"];
[alku: "ttav",  luokka: johdin_ttAvA, äs: a, jatko: @jatko_v,  perusmuoto: "ttava"];
[alku: "ttäv",  luokka: johdin_ttAvA, äs: ä, jatko: @jatko_v,  perusmuoto: "ttävä"];
[alku: "tava",  luokka: johdin_tAvA, äs: a, jatko: @jatko_vA, perusmuoto: "tava"];
[alku: "tävä",  luokka: johdin_tAvA, äs: ä, jatko: @jatko_vA, perusmuoto: "tävä"];
[alku: "tav",   luokka: johdin_tAvA, äs: a, jatko: @jatko_v,  perusmuoto: "tava"];
[alku: "täv",   luokka: johdin_tAvA, äs: ä, jatko: @jatko_v,  perusmuoto: "tävä"];


[alku: "ttavuu", luokka: johdin_ttAvA, jluokka: nimisana, äs: a, jatko: <kalleus>, perusmuoto: "ttavuus"];
[alku: "ttävyy", luokka: johdin_ttAvA, jluokka: nimisana, äs: ä, jatko: <kalleus>, perusmuoto: "ttävyys"];
[alku: "tavuu",  luokka: johdin_tAvA, jluokka: nimisana, äs: a, jatko: <kalleus>, perusmuoto: "tavuus"];
[alku: "tävyy",  luokka: johdin_tAvA, jluokka: nimisana, äs: ä, jatko: <kalleus>, perusmuoto: "tävyys"];

[alku: "ttavaisuu", luokka: johdin_ttAvA, jluokka: nimisana, äs: a, jatko: <kalleus>, perusmuoto: "ttavaisuus"];
[alku: "ttäväisyy", luokka: johdin_ttAvA, jluokka: nimisana, äs: ä, jatko: <kalleus>, perusmuoto: "ttäväisyys"];
[alku: "tavaisuu",  luokka: johdin_tAvA, jluokka: nimisana, äs: a, jatko: <kalleus>, perusmuoto: "tavaisuus"];
[alku: "täväisyy",  luokka: johdin_tAvA, jluokka: nimisana, äs: ä, jatko: <kalleus>, perusmuoto: "täväisyys"];

[alku: "ttavai", luokka: johdin_ttAvA, äs: a, jatko: <nainen>, perusmuoto: "ttavainen"];
[alku: "ttäväi", luokka: johdin_ttAvA, äs: ä, jatko: <nainen>, perusmuoto: "ttäväinen"];
[alku: "tavai",  luokka: johdin_tAvA, äs: a, jatko: <nainen>, perusmuoto: "tavainen"];
[alku: "täväi",  luokka: johdin_tAvA, äs: ä, jatko: <nainen>, perusmuoto: "täväinen"];



# Toinen laatutapa: puno+nut.
#
define @jatko_nUt := <liitesana, osanto_tA, loppu>;

[alku: "lut", luokka: johdin_lUt, äs: a, jatko: @jatko_nUt];
[alku: "lyt", luokka: johdin_lUt, äs: ä, jatko: @jatko_nUt];
[alku: "nut", luokka: johdin_nUt, äs: a, jatko: @jatko_nUt];
[alku: "nyt", luokka: johdin_nUt, äs: ä, jatko: @jatko_nUt];
[alku: "rut", luokka: johdin_rUt, äs: a, jatko: @jatko_nUt];
[alku: "ryt", luokka: johdin_rUt, äs: ä, jatko: @jatko_nUt];
[alku: "sut", luokka: johdin_sUt_stU, laatutapa: johdin_nUt, äs: a, jatko: @jatko_nUt];
[alku: "syt", luokka: johdin_sUt_stU, laatutapa: johdin_nUt, äs: ä, jatko: @jatko_nUt];


define @jatko_ee := <omistusliite, omanto_n, olento_nA, tulento_ksi,
                     sisäolento_ssA, sisätulento_seen,
                     ulkopaikallissija_llA,
                     vajanto_ttA, kerronto_sti, nimentö_t, voittoaste>;

define @jatko_e := <omanto_iT,
                    osanto_itA, olento_inA, sija_monikko_1,
                    sisätulento_isiin, sisätulento_ihin,
                    ulkopaikallissija_illA,
                    vajanto_ittA, seuranto_ine, yliaste>;

[alku: "lee", luokka: johdin_lUt, äs: a, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "lut"];
[alku: "lee", luokka: johdin_lUt, äs: ä, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "lyt"];
[alku: "nee", luokka: johdin_nUt, äs: a, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "nut"];
[alku: "nee", luokka: johdin_nUt, äs: ä, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "nyt"];
[alku: "ree", luokka: johdin_rUt, äs: a, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "rut"];
[alku: "ree", luokka: johdin_rUt, äs: ä, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "ryt"];
[alku: "see", luokka: johdin_sUt_stU, äs: a, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "sut"];
[alku: "see", luokka: johdin_sUt_stU, äs: ä, luku: yksikkö, jatko: @jatko_ee, perusmuoto: "syt"];

[alku: "le",  luokka: johdin_lUt, äs: a, luku: monikko, jatko: @jatko_e, perusmuoto: "lut"];
[alku: "le",  luokka: johdin_lUt, äs: ä, luku: monikko, jatko: @jatko_e, perusmuoto: "lyt"];
[alku: "ne",  luokka: johdin_nUt, äs: a, luku: monikko, jatko: @jatko_e, perusmuoto: "nut"];
[alku: "ne",  luokka: johdin_nUt, äs: ä, luku: monikko, jatko: @jatko_e, perusmuoto: "nyt"];
[alku: "re",  luokka: johdin_rUt, äs: a, luku: monikko, jatko: @jatko_e, perusmuoto: "rut"];
[alku: "re",  luokka: johdin_rUt, äs: ä, luku: monikko, jatko: @jatko_e, perusmuoto: "ryt"];
[alku: "se",  luokka: johdin_sUt_stU, äs: a, luku: monikko, jatko: @jatko_e, perusmuoto: "sut"];
[alku: "se",  luokka: johdin_sUt_stU, äs: ä, luku: monikko, jatko: @jatko_e, perusmuoto: "syt"];


[alku: "leisuu", luokka: johdin_lUt, jluokka: nimisana, äs: a, luku: yksikkö, jatko: <kalleus>, perusmuoto: "leisuus"];
[alku: "leisyy", luokka: johdin_lUt, jluokka: nimisana, äs: ä, luku: yksikkö, jatko: <kalleus>, perusmuoto: "leisyys"];
[alku: "neisuu", luokka: johdin_nUt, jluokka: nimisana, äs: a, luku: yksikkö, jatko: <kalleus>, perusmuoto: "neisuus"];
[alku: "neisyy", luokka: johdin_nUt, jluokka: nimisana, äs: ä, luku: yksikkö, jatko: <kalleus>, perusmuoto: "neisyys"];


define @jatko_vahva_aste :=
       <omistusliite, osanto_A, olento_nA, sisätulento_Vn,
        omanto_jen, osanto_jA, olento_inA, sisätulento_ihin, seuranto_ine,
        liitesana, loppu, johdin_Us>;

define @jatko_heikko_aste :=
       <omanto_n, tulento_ksi, sisäolento_ssA,
        ulkopaikallissija_llA, vajanto_ttA,
        kerronto_sti,
        nimentö_t, omanto_iT, osanto_itA,
        sija_monikko_1,
        ulkopaikallissija_illA,
        vajanto_ittA,
        voittoaste, yliaste>;

define @jatko := @jatko_vahva_aste + @jatko_heikko_aste;


[alku: "ttu", luokka: johdin_ttU, laatutapa: johdin_ttU, äs: a, jatko: @jatko_vahva_aste - <omistusliite>,  perusmuoto: "ttu"];
[alku: "tty", luokka: johdin_ttU, laatutapa: johdin_ttU, äs: ä, jatko: @jatko_vahva_aste - <omistusliite>,  perusmuoto: "tty"];
[alku: "tu",  luokka: johdin_ttU, laatutapa: johdin_ttU, äs: a, jatko: @jatko_heikko_aste - <omanto_it, osanto_itA>, perusmuoto: "ttu"];
[alku: "ty",  luokka: johdin_ttU, laatutapa: johdin_ttU, äs: ä, jatko: @jatko_heikko_aste - <omanto_it, osanto_itA>, perusmuoto: "tty"];

[alku: "du", luokka: johdin_dU, äs: a, jatko: @jatko_heikko_aste, perusmuoto: "tu"];
[alku: "dy", luokka: johdin_dU, äs: ä, jatko: @jatko_heikko_aste, perusmuoto: "ty"];
[alku: "lu", luokka: johdin_lU, äs: a, jatko: @jatko_heikko_aste, perusmuoto: "tu"];
[alku: "ly", luokka: johdin_lU, äs: ä, jatko: @jatko_heikko_aste, perusmuoto: "ty"];
[alku: "nu", luokka: johdin_nU, äs: a, jatko: @jatko_heikko_aste, perusmuoto: "tu"];
[alku: "ny", luokka: johdin_nU, äs: ä, jatko: @jatko_heikko_aste, perusmuoto: "ty"];
[alku: "ru", luokka: johdin_rU, äs: a, jatko: @jatko_heikko_aste, perusmuoto: "tu"];
[alku: "ry", luokka: johdin_rU, äs: ä, jatko: @jatko_heikko_aste, perusmuoto: "ty"];
[alku: "tu", luokka: johdin_tU, äs: a, jatko: @jatko_vahva_aste, perusmuoto: "tu"];
[alku: "ty", luokka: johdin_tU, äs: ä, jatko: @jatko_vahva_aste, perusmuoto: "ty"];

[alku: "tu", luokka: johdin_sUt_stU, laatutapa: johdin_ttU, äs: a, jatko: @jatko - <omanto_it, osanto_itA, omistusliite>, perusmuoto: "tu"];
[alku: "ty", luokka: johdin_sUt_stU, laatutapa: johdin_ttU, äs: ä, jatko: @jatko - <omanto_it, osanto_itA, omistusliite>, perusmuoto: "ty"];


define @m_jatko := <omanto_ien, osanto_iA, olento_inA, sija_monikko_1,
                    sisätulento_iin,
                    ulkopaikallissija_illA,
                    vajanto_ittA, seuranto_ine>;


define @mA_jatko := <omistusliite, liitesana, loppu, omanto_n,
                     osanto_A, olento_nA, tulento_ksi,
                     sisäolento_ssA, sisätulento_Vn,
                     ulkopaikallissija_llA,
                     vajanto_ttA,
                     nimentö_t, omanto_in, johdin_tOn>;

# Puno+ma, teke+mä.
#
[alku: "m",  luokka: johdin_mA, äs: a, jatko: @m_jatko,  perusmuoto: "ma"];
[alku: "m",  luokka: johdin_mA, äs: ä, jatko: @m_jatko,  perusmuoto: "mä"];
[alku: "ma", luokka: johdin_mA, äs: a, jatko: @mA_jatko, perusmuoto: "ma", tiedot: <ei_ysa>];
[alku: "mä", luokka: johdin_mA, äs: ä, jatko: @mA_jatko, perusmuoto: "mä", tiedot: <ei_ysa>];

# Maa+ton, pää+tön, puno+maton, teke+mätön.

define @jatko_tOn := <liitesana, loppu, osanto_tA, omanto_ten, olento_nA>;

[alku: "ton", luokka: johdin_tOn, äs: a, kielto: yes, jatko: @jatko_tOn, perusmuoto: "ton"];
[alku: "tön", luokka: johdin_tOn, äs: ä, kielto: yes, jatko: @jatko_tOn, perusmuoto: "tön"];


define @jatko_ttOmA := <omistusliite, omanto_n, osanto_A, olento_nA, tulento_ksi,
                        sisäolento_ssA, sisätulento_Vn,
                        ulkopaikallissija_llA,
                        vajanto_ttA, kerronto_sti, voittoaste,
                        nimentö_t, omanto_in>;

[alku: "ttoma", luokka: johdin_tOn, äs: a, kielto: yes, jatko: @jatko_ttOmA, perusmuoto: "ton"];
[alku: "ttömä", luokka: johdin_tOn, äs: ä, kielto: yes, jatko: @jatko_ttOmA, perusmuoto: "tön"];

define @jatko_ttOm := <omanto_ien, osanto_iA, olento_inA, sija_monikko_1,
                       sisätulento_iin,
                       ulkopaikallissija_illA,
                       vajanto_ittA, seuranto_ine, yliaste>;

[alku: "ttom", luokka: johdin_tOn, äs: a, kielto: yes, jatko: @jatko_ttOm, perusmuoto: "ton"];
[alku: "ttöm", luokka: johdin_tOn, äs: ä, kielto: yes, jatko: @jatko_ttOm, perusmuoto: "tön"];


[alku: "ttom", luokka: johdin_tOn, äs: a, kielto: yes, jatko: <johdin_UUs>, perusmuoto: "ttom"];
[alku: "ttöm", luokka: johdin_tOn, äs: ä, kielto: yes, jatko: <johdin_UUs>, perusmuoto: "ttöm"];


[alku: "-", luokka: tavuviiva, äs: aä, jatko: @yhdyssana + <loppu>];  # Linja-auto.

[alku: ":", luokka: kaksoispiste, äs: aä, jatko: <sijapääte>];


# Punoa => punonta, hallita => hallinta, jne.

define @jatko_ntA := <omistusliite, liitesana, loppu, osanto_A, olento_nA,
                      sisätulento_Vn, omanto_in> + @yhdyssana + <johdin_inen>;

define @jatko_nnA := <omanto_n, tulento_ksi, sisäolento_ssA,
                      ulkopaikallissija_llA,
                      vajanto_ttA, nimentö_t, johdin_tOn>;

define @jatko_ntO := <omanto_jen, osanto_jA, olento_inA, sisätulento_ihin, seuranto_ine>;

define @jatko_nnO := <omanto_iT, osanto_itA, sija_monikko_1,
                      ulkopaikallissija_illA,
                      vajanto_ittA, sisätulento_ihin>;

[alku: "nta", luokka: johdin_ntA, äs: a, jatko: @jatko_ntA, perusmuoto: "nta"];
[alku: "ntä", luokka: johdin_ntA, äs: ä, jatko: @jatko_ntA, perusmuoto: "ntä"];

[alku: "nna", luokka: johdin_ntA, äs: a, jatko: @jatko_nnA, perusmuoto: "nta"];
[alku: "nnä", luokka: johdin_ntA, äs: ä, jatko: @jatko_nnA, perusmuoto: "ntä"];

[alku: "nto", luokka: johdin_ntA, äs: a, jatko: @jatko_ntO, perusmuoto: "nta"];
[alku: "ntö", luokka: johdin_ntA, äs: ä, jatko: @jatko_ntO, perusmuoto: "ntä"];

[alku: "nno", luokka: johdin_ntA, äs: a, jatko: @jatko_nnO, perusmuoto: "nta"];
[alku: "nnö", luokka: johdin_ntA, äs: ä, jatko: @jatko_nnO, perusmuoto: "ntä"];


# Voida => vointi.

define @jatko_nti := <omistusliite, liitesana, loppu, osanto_A, olento_nA,
                      sisätulento_Vn, omanto_en> + @yhdyssana;

define @jatko_nni := <omanto_n, tulento_ksi, sisäolento_ssA,
                      ulkopaikallissija_llA,
                      vajanto_ttA, voittoaste, johdin_tOn,
                      nimentö_t>;

define @jatko_nte := <osanto_jA, olento_inA, sisätulento_ihin, seuranto_ine>;

define @jatko_nne := <sija_monikko_1,
                      ulkopaikallissija_illA,
                      vajanto_ittA>;

[alku: "nti", luokka: johdin_nti, äs: aä, jatko: @jatko_nti, perusmuoto: "nti"];
[alku: "nni", luokka: johdin_nti, äs: aä, jatko: @jatko_nni, perusmuoto: "nti"];

[alku: "nte", luokka: johdin_nti, äs: aä, jatko: @jatko_nte, perusmuoto: "nti"];
[alku: "nne", luokka: johdin_nti, äs: aä, jatko: @jatko_nne, perusmuoto: "nti"];

[alku: "nt", luokka: johdin_nti, äs: aä, jatko: <johdin_inen>, perusmuoto: "nt"];


define @jatko_Us := <liitesana, loppu> + @yhdyssana;
define @jatko_Ut := <osanto_tA>;
define @jatko_te := <omistusliite, olento_nA, sisätulento_Vn>;
define @jatko_de := <omanto_n, tulento_ksi, sisäolento_ssA,
                     ulkopaikallissija_llA, vajanto_ttA,
                     johdin_tOn, nimentö_t>;
define @jatko_ks := <omanto_ien, osanto_iA, olento_inA, sija_monikko_1,
                     sisätulento_iin,
                     ulkopaikallissija_illA,
                     vajanto_ittA, seuranto_ine, johdin_inen,
                     johdin_ittAin>;

[alku: "us", luokka: johdin_Us, äs: a, jatko: @jatko_Us, perusmuoto: "us"];
[alku: "ys", luokka: johdin_Us, äs: ä, jatko: @jatko_Us, perusmuoto: "ys"];

[alku: "ut", luokka: johdin_Us, äs: a, jatko: @jatko_Ut, perusmuoto: "us"];
[alku: "yt", luokka: johdin_Us, äs: ä, jatko: @jatko_Ut, perusmuoto: "ys"];

[alku: "ute", luokka: johdin_Us, äs: a, jatko: @jatko_te, perusmuoto: "us"];
[alku: "yte", luokka: johdin_Us, äs: ä, jatko: @jatko_te, perusmuoto: "ys"];

[alku: "ude", luokka: johdin_Us, äs: a, jatko: @jatko_de, perusmuoto: "us"];
[alku: "yde", luokka: johdin_Us, äs: ä, jatko: @jatko_de, perusmuoto: "ys"];

[alku: "uks", luokka: johdin_Us, äs: a, jatko: @jatko_ks, perusmuoto: "us"];
[alku: "yks", luokka: johdin_Us, äs: ä, jatko: @jatko_ks, perusmuoto: "ys"];


[alku: "uus", luokka: johdin_UUs, äs: a, jatko: @jatko_Us, perusmuoto: "uus"];
[alku: "yys", luokka: johdin_UUs, äs: ä, jatko: @jatko_Us, perusmuoto: "yys"];

[alku: "uut", luokka: johdin_UUs, äs: a, jatko: @jatko_Ut, perusmuoto: "uus"];
[alku: "yyt", luokka: johdin_UUs, äs: ä, jatko: @jatko_Ut, perusmuoto: "yys"];

[alku: "uute", luokka: johdin_UUs, äs: a, jatko: @jatko_te, perusmuoto: "uus"];
[alku: "yyte", luokka: johdin_UUs, äs: ä, jatko: @jatko_te, perusmuoto: "yys"];

[alku: "uude", luokka: johdin_UUs, äs: a, jatko: @jatko_de, perusmuoto: "uus"];
[alku: "yyde", luokka: johdin_UUs, äs: ä, jatko: @jatko_de, perusmuoto: "yys"];

[alku: "uuks", luokka: johdin_UUs, äs: a, jatko: @jatko_ks, perusmuoto: "uus"];
[alku: "yyks", luokka: johdin_UUs, äs: ä, jatko: @jatko_ks, perusmuoto: "yys"];


# Vastaus, vastauksen.

define @jatko_vastaus := <liitesana, osanto_tA, omanto_ten, loppu> + @yhdyssana;

define @jatko_vastaukse := @jatko_de + @jatko_te;

[alku: "us",   luokka: johdin_Us_ksen, äs: a, jatko: @jatko_vastaus,   perusmuoto: "us"];
[alku: "ys",   luokka: johdin_Us_ksen, äs: ä, jatko: @jatko_vastaus,   perusmuoto: "ys"];
[alku: "ukse", luokka: johdin_Us_ksen, äs: a, jatko: @jatko_vastaukse, perusmuoto: "us"];
[alku: "ykse", luokka: johdin_Us_ksen, äs: ä, jatko: @jatko_vastaukse, perusmuoto: "ys"];
[alku: "uks",  luokka: johdin_Us_ksen, äs: a, jatko: @jatko_ks,  perusmuoto: "us"];
[alku: "yks",  luokka: johdin_Us_ksen, äs: ä, jatko: @jatko_ks,  perusmuoto: "ys"];

# Juhla => juhlallinen
[alku: "llinen", luokka: johdin_tOn, äs: aä, kielto: no, perusmuoto: "llinen", jatko: <liitesana, loppu>];
[alku: "llise",  luokka: johdin_tOn, äs: aä, kielto: no, perusmuoto: "llinen" ,jatko: @jatko_se + <kerronto_sti, voittoaste> - <omistusliite>];
[alku: "llis",   luokka: johdin_tOn, äs: aä, kielto: no, perusmuoto: "llinen", jatko: @jatko_s + <johdin_ittAin, johdin_UUs, yliaste>];

# Juhla => juhlainen.
[alku: "inen", luokka: johdin_inen, äs: aä, perusmuoto: "inen", jatko: <liitesana, loppu>];
[alku: "ise",  luokka: johdin_inen, äs: aä, perusmuoto: "inen", jatko: @jatko_se + <kerronto_sti, voittoaste>];
[alku: "is",   luokka: johdin_inen, äs: aä, perusmuoto: "inen", jatko: @jatko_s + <johdin_UUs, yliaste>];

# Juhla => juhlittain.
[alku: "ittain", luokka: johdin_ittAin, äs: a, perusmuoto: "ittain", jatko: <liitesana, loppu>];
[alku: "ittäin", luokka: johdin_ittAin, äs: ä, perusmuoto: "ittäin", jatko: <liitesana, loppu>];

# Juhla => juhla+lainen. Parempi esimerikki: kaupunki+lainen.
[alku: "lainen", luokka: johdin_lAinen, äs: a, perusmuoto: "lainen", jatko: <liitesana, loppu>];
[alku: "laise",  luokka: johdin_lAinen, äs: a, perusmuoto: "lainen", jatko: @jatko_se + <kerronto_sti, voittoaste>];
[alku: "lais",   luokka: johdin_lAinen, äs: a, perusmuoto: "lainen", jatko: @jatko_s + <johdin_ittAin, johdin_UUs, yliaste>];
[alku: "läinen", luokka: johdin_lAinen, äs: ä, perusmuoto: "läinen", jatko: <liitesana, loppu>];
[alku: "läise",  luokka: johdin_lAinen, äs: ä, perusmuoto: "läinen", jatko: @jatko_se + <kerronto_sti, voittoaste>];
[alku: "läis",   luokka: johdin_lAinen, äs: ä, perusmuoto: "läinen", jatko: @jatko_s + <johdin_ittAin, johdin_UUs, yliaste>];

# Juhla => juhla+mainen.
[alku: "mainen", luokka: johdin_mAinen, äs: a, perusmuoto: "mainen", jatko: <liitesana, loppu>];
[alku: "maise",  luokka: johdin_mAinen, äs: a, perusmuoto: "mainen", jatko: @jatko_se + <kerronto_sti, voittoaste>];
[alku: "mais",   luokka: johdin_mAinen, äs: a, perusmuoto: "mainen", jatko: @jatko_s + <johdin_ittAin, johdin_UUs, yliaste>];
[alku: "mäinen", luokka: johdin_mAinen, äs: ä, perusmuoto: "mäinen", jatko: <liitesana, loppu>];
[alku: "mäise",  luokka: johdin_mAinen, äs: ä, perusmuoto: "mäinen", jatko: @jatko_se + <kerronto_sti, voittoaste>];
[alku: "mäis",   luokka: johdin_mAinen, äs: ä, perusmuoto: "mäinen", jatko: @jatko_s + <johdin_ittAin, johdin_UUs, yliaste>];


# Hyvän+lainen, paha+nlainen. Kentän äs täytyy olla aä, koska ä:llistä muotoa ei ole.
[perusmuoto: "nlainen", alku: "nlai", luokka: johdin_nlainen, jatko: <nainen>, äs: a];


define @jatko_tar := <liitesana, loppu, osanto_tA, omanto_ten> + @yhdyssana;

define @jatko_ttar := <omanto_ien, osanto_iA, olento_inA,
                       sija_monikko_1, sisätulento_iin,
                       ulkopaikallissija_illA,
                       vajanto_ittA, seuranto_ine, johdin_UUs>;

define @jatko_ttare := <omanto_n, olento_nA, tulento_ksi,
                        sisäolento_ssA, sisätulento_Vn,
                        ulkopaikallissija_llA,
                        vajanto_ttA, nimentö_t, omistusliite>;

[alku: "tar",   luokka: johdin_tAr, äs: a, perusmuoto: "tar", jatko: @jatko_tar];
[alku: "ttar",  luokka: johdin_tAr, äs: a, perusmuoto: "tar", jatko: @jatko_ttar];
[alku: "ttare", luokka: johdin_tAr, äs: a, perusmuoto: "tar", jatko: @jatko_ttare];

[alku: "tär",   luokka: johdin_tAr, äs: ä, perusmuoto: "tär", jatko: @jatko_tar];
[alku: "ttär",  luokka: johdin_tAr, äs: ä, perusmuoto: "tär", jatko: @jatko_ttar];
[alku: "ttäre", luokka: johdin_tAr, äs: ä, perusmuoto: "tär", jatko: @jatko_ttare];


define @jatko_jA :=
  <tavuviiva, omistusliite, nimentö, omanto_n, osanto_A,
   osanto_tA, olento_nA, tulento_ksi, sisäolento_ssA,
   sisätulento_Vn, ulkopaikallissija_llA,
   vajanto_ttA, kerronto_sti,
   nimisana, laatusana,
   johdin_tOn, johdin_tAr, nimentö_t, omanto_in,
   johdin_mAinen, liitesana, loppu>;


define @jatko_j_myyjä :=
  <omanto_ien, osanto_iA, olento_inA,
   sija_monikko_1, sisätulento_iin,
   ulkopaikallissija_illA,
   vajanto_ittA, seuranto_ine>;


[alku: "j", luokka: johdin_jA_myyjä, äs: aä, perusmuoto: "j", jatko: <johdin_UUs, johdin_ittAin>];
[alku: "j", luokka: johdin_jA_myyjä, äs: a, perusmuoto: "ja", jatko: @jatko_j_myyjä];
[alku: "j", luokka: johdin_jA_myyjä, äs: ä, perusmuoto: "jä", jatko: @jatko_j_myyjä];

[alku: "ja", luokka: johdin_jA_myyjä, äs: a, perusmuoto: "ja", jatko: @jatko_jA];
[alku: "jä", luokka: johdin_jA_myyjä, äs: ä, perusmuoto: "jä", jatko: @jatko_jA];



define @jatko_jA_kulkija_kantaja := @jatko_jA + <osanto_tA>;


define @jatko_jO_kulkija_kantaja :=
  <omanto_iT, osanto_itA, olento_inA,
   sija_monikko_1, sisätulento_ihin,
   ulkopaikallissija_illA,
   vajanto_ittA, seuranto_ine, johdin_ittAin>;



[alku: "j", luokka: johdin_jA_kulkija, äs: aä, perusmuoto: "j", jatko: <johdin_UUs>];

[alku: "ja", luokka: johdin_jA_kulkija, äs: a, perusmuoto: "ja", jatko: @jatko_jA_kulkija_kantaja];
[alku: "jo", luokka: johdin_jA_kulkija, äs: a, perusmuoto: "ja", jatko: @jatko_jO_kulkija_kantaja];

[alku: "jä", luokka: johdin_jA_kulkija, äs: ä, perusmuoto: "jä", jatko: @jatko_jA_kulkija_kantaja];
[alku: "jö", luokka: johdin_jA_kulkija, äs: ä, perusmuoto: "jä", jatko: @jatko_jO_kulkija_kantaja];


[alku: "j", luokka: johdin_jA_kantaja, äs: aä, perusmuoto: "j", jatko: <johdin_ittAin, johdin_UUs>];

[alku: "j", luokka: johdin_jA_kantaja, äs: a, perusmuoto: "ja", jatko: @jatko_j_myyjä];
[alku: "j", luokka: johdin_jA_kantaja, äs: ä, perusmuoto: "jä", jatko: @jatko_j_myyjä];

[alku: "ja", luokka: johdin_jA_kantaja, äs: a, perusmuoto: "ja", jatko: @jatko_jA_kulkija_kantaja];
[alku: "jo", luokka: johdin_jA_kantaja, äs: a, perusmuoto: "ja", jatko: @jatko_jO_kulkija_kantaja];

[alku: "jä", luokka: johdin_jA_kantaja, äs: ä, perusmuoto: "jä", jatko: @jatko_jA_kulkija_kantaja];
[alku: "jö", luokka: johdin_jA_kantaja, äs: ä, perusmuoto: "jä", jatko: @jatko_jO_kulkija_kantaja];

[perusmuoto: "tu", alku: "", luokka: johdin_tU_lU_oltu,     jatko: <oltu>,     äs: a];
