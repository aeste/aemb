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

#define BOOT_BASE 0x00020000 ///< Base address of the kernel

#define SRAM_BASE 0x00001000 ///< Base address of RAM block
#define SRAM_SIZE 0x00010000 ///< Size of RAM block

#include "aemb/core.hh"

typedef void (boot_addr)(void);

// Replacements for STDIO

void uxe_putc(char c)
{
  volatile char *COUT = (char *) 0xFFFFFFC0;
  *COUT = c;
}

void uxe_putw(char * msg)
{
  for (char *c = msg; *c != 0; c++) uxe_putc(*c);
}

void uxe_puts(char * msg)
{
  uxe_putw(msg);
  uxe_putc('\n');
}


// Main execution environment.

int main ()
{
  // Welcome banner
  uxe_puts("Micro Execution Environment 11.07");
  uxe_puts("Copyright (C) 2011 Aeste Works (M) S/B.");
  //uxe_puts("\nThis program comes with ABSOLUTELY NO WARRANTY;\nThis is free software, and you are welcome to redistribute it under certain conditions;\nFor more details, see the GPL3.txt file included.\n");
  
  // Load kernel image (SD/MMC)
  
  // Print kernel base address (only works with 0-9)
  uxe_putw("Boot @");
  for (unsigned int i = 0, k = BOOT_BASE; i < 8; ++i, k <<= 4) {
    uxe_putc( (k >> 28) + 0x30 );
  }
  uxe_putc('\n');
  
  // Jump to next stage
  ((boot_addr*) BOOT_BASE)();
  
  // This should *NEVER* execute.
  return -1;
}
