/* Libvoikko: Finnish spellchecker and hyphenator library
 * Copyright (C) 2006 Harri Pitkänen <hatapitk@iki.fi>
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

#include "voikko_defs.h"
#include "voikko_setup.h"
#include <pwd.h>
#include <malaga.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>


int voikko_set_bool_option(int handle, int option, int value) {
	switch (option) {
		case VOIKKO_OPT_IGNORE_DOT:
			if (value) voikko_options.ignore_dot = 1;
			else voikko_options.ignore_dot = 0;
			return 1;
		case VOIKKO_OPT_IGNORE_NUMBERS:
			if (value) voikko_options.ignore_numbers = 1;
			else voikko_options.ignore_numbers = 0;
			return 1;
		case VOIKKO_OPT_IGNORE_UPPERCASE:
			if (value) voikko_options.ignore_uppercase = 1;
			else voikko_options.ignore_uppercase = 0;
			return 1;
		case VOIKKO_OPT_NO_UGLY_HYPHENATION:
			if (value) voikko_options.no_ugly_hyphenation = 1;
			else voikko_options.no_ugly_hyphenation = 0;
			return 1;
	}
	return 0;
}

int voikko_set_int_option(int handle, int option, int value) {
	switch (option) {
		case VOIKKO_INTERSECT_COMPOUND_LEVEL:
			voikko_options.intersect_compound_level = value;
			return 1;
	}
	return 0;
}

int voikko_set_string_option(int handle, int option, const char * value) {
	switch (option) {
		case VOIKKO_OPT_ENCODING:
			if (!value) return 0;
			voikko_options.encoding = value;
			return 1;
	}
	return 0;
}

const char * voikko_init(int * handle, const char * langcode) {
	char * project = malloc(1024);
	voikko_options.ignore_dot = 0;
	voikko_options.ignore_numbers = 0;
	voikko_options.ignore_uppercase = 0;
	voikko_options.no_ugly_hyphenation = 0;
	voikko_options.intersect_compound_level = 1;
	voikko_options.encoding = "UTF-8";
	
	/* FIXME: Temporary hack needed for MT unsafe malaga library */
	if (voikko_handle_count++ > 0) return "Maximum handle count exceeded";
	
	if (!voikko_find_malaga_project(project, 1024, langcode)) {
		free(project);
		return "Unsupported language";
	}
	init_libmalaga(project);
	free(project);
	if (malaga_error) {
		voikko_handle_count--;
		return malaga_error;
	}
	*handle = voikko_handle_count;
	return 0;
}

int voikko_terminate(int handle) {
	if (handle == 1 && voikko_handle_count > 0) {
		voikko_handle_count--;
		terminate_libmalaga();
		return 1;
	}
	else return 0;
}

int voikko_find_malaga_project(char * buffer, int buflen, const char * langcode) {
	struct passwd pwd;
	struct stat sbuf;
	struct passwd * pwd_result;
	char * tmp_buf = malloc(buflen + 2048);
	if (strcmp(langcode, "fi_FI") == 0) {
#ifdef WIN32
		/* TODO: Check the Windows registry */
#endif
#ifdef HAVE_GETPWUID_R
		/* Check for project file in $HOME/.voikko/suomi.pro */
		getpwuid_r(getuid(), &pwd, tmp_buf, buflen + 2048, &pwd_result);
		if (pwd_result && pwd.pw_dir && strlen(pwd.pw_dir) < buflen - 19 ) {
			strcpy(buffer, pwd.pw_dir);
			strcpy(buffer + strlen(pwd.pw_dir), "/.voikko/suomi.pro");
			if (stat(buffer, &sbuf) == 0) {
				free(tmp_buf);
				return 1;
			}
		}
#endif
		/* Use the compile time default project file */
		strcpy(buffer, DICTIONARY_PATH "/suomi.pro");
		free(tmp_buf);
		return 1;
	}
	/* Language is not supported */
	free(tmp_buf);
	return 0;
}
