
int main() {

  char * TRIS = (char *) 0x40000000;
  char * GPIO = (char *) 0x40000004;

  // set TRIS to output
  *TRIS = 0xFF;

  // LED counter
  for (char i=0; ; i++) {
    *GPIO = i;
  }
  
  return 0;
}
