#include <stdlib.h>
#include <stdio.h>
#include "one.c"
#include "two.c"
#include "three.c"
#include "mult.c"

int main() {
   int one;
   int two;
   int three;
   int multfunc;

   one = f1(1,2);

   two = max2(4,5);
   printf("max 2%d\n", two);

   three = max3(7,4,5);
   printf("max3 %d\n", three);

   multfunc = mult(5,6);
   printf("mult %d\n", multfunc);

   return 0;
}
