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

#define KERNEL_BASE 0x00020000 ///< Base address of the kernel

#include <cstdlib>
#include <cstdio>
#include "aemb/core.hh"

typedef void (boot_addr)(void);

int main ()
{
  // Welcome banner
  puts("Micro Execution Environment.");
  puts("Copyright (C) 2011 Aeste Works (M) S/B.");
  //puts("\nThis program comes with ABSOLUTELY NO WARRANTY;\nThis is free software, and you are welcome to redistribute it under certain conditions;\nFor more details, see the GPL3.txt file included.\n");

  // Enable stdin/out

  // Load kernel image (SD/MMC)

  // Print kernel base address (only works with 0-9)
  for (unsigned int i = 0, a = KERNEL_BASE; i < 8; ++i, a = a << 4) {
      putchar( (a >> 28) + 0x30 );
  }
  putchar('\n');

  // Jump to kernel execution
  ((boot_addr*) KERNEL_BASE)();

  // This should *NEVER* execute.
  return EXIT_FAILURE;
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

