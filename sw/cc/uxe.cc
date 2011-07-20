/* 
** AEMB Micro Execution Environment
** Copyright (C) 2011 Aeste Works (M) S/B.
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

#define KERNEL_BASE 0x20000 ///< Base address of the kernel

#include <cstdlib>
#include <cstdio>
#include "aemb/core.hh"

typedef void (boot_addr)(void);

int main (int argc, char* argv[])
{
  // Welcome banner
  puts("ALAM Micro Execution Environment.");
  puts("Copyright (C) 2011 Aeste Works (M) S/B.\n");

  puts("This program comes with ABSOLUTELY NO WARRANTY;");
  puts("This is free software, and you are welcome to redistribute it under certain conditions;");
  puts("For more details, see the GPL3.txt file included.");

  // Enable STDIN/OUT

  // Jump to kernel execution
  puts("\nBooting...");
  ((boot_addr*) KERNEL_BASE)();

  return EXIT_FAILURE; // This should *NEVER* execute.
}

void outbyte(char c) 
{
  volatile char *COUT = (char *) 0xFFFFFFC0;
  *COUT = c;
}

char inbyte() 
{
  return 0;
}

