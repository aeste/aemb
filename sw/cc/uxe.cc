/* 
** AEMB Micro Execution Environment
** Copyright (C) 2011 Shawn Tan <shawn.tan@aeste.net>
**
** This file is part of AEMB.
**
** AEMB is free software: you can redistribute it and/or modify it
** under the terms of the GNU General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** AEMB is distributed in the hope that it will be useful, but WITHOUT
** ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
** or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
** License for more details.
**
** You should have received a copy of the GNU General Public License
** along with AEMB.  If not, see <http://www.gnu.org/licenses/>.
*/

/**
   AEMB Early Boot-Loader 
   @file uxe.cc

*/

#include <cstdlib>
#include <cstdio>
#include "aemb/core.hh"


void outbyte(char c) 
{
  volatile char *COUT = (char *) 0xFFFFFFC0;
  *COUT = c;
}

char inbyte() 
{
  return 0;
}

int main (int argc, char* argv[])
{
  puts("AEMB Micro Execution Environment.");

  return EXIT_FAILURE; // This should *NEVER* execute.
}
