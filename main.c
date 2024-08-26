void kernel_main(void) {
  const char *str = "Hello from kernel!";
  char *vidptr = (char *)0xb8000; // Video memory in text mode
  unsigned int i = 0;
  unsigned int j = 0;

  // Clear the screen by writing spaces to each cell
  while (j < 80 * 25 * 2) {
    vidptr[j] = ' ';
    vidptr[j + 1] = 0x07; // Attribute-byte: light grey on black
    j += 2;
  }

  j = 0;
  // Write the string to video memory
  while (str[i] != '\0') {
    vidptr[j] = str[i];
    vidptr[j + 1] = 0x07; // Attribute-byte: light grey on black
    ++i;
    j += 2;
  }

  return;
}
