//============================================================================
// Name        : main.cpp
// Author      : veeYceeY
// Version     :
// Copyright   : Your copyright notice
// Description : Hello RISC-V World in C++
//============================================================================

//#include <iostream>
//using namespace std;

#include <stdint.h>
//
void led(int* gpio,int val);

int main()
{
  //int gpio;
  int *gpio;
  int *a,*b,*c;
  int x,y,z;
  register uint32_t temp = 0x86;
  a=&z;
  b=&y;
  c=&x;
  //a=(int*)0x00010110;
  //b=(int*)0x00010114;
  //c=(int*)0x00010118;
  *a=5;
  *b=-10;
  *c=*a+*b;
  gpio =(int*) 0x00100001;
  *gpio=0x86;
  asm volatile("csrs mie, %[temp]\n":: [temp] "r" (temp));
  temp = 0x84;
  asm volatile("nop\n");
  asm volatile("nop\n");
  asm volatile("nop\n");
  asm volatile("nop\n");
  asm volatile("nop\n");
  asm volatile("nop\n");
  asm volatile("csrc mie, %[temp]\n":: [temp] "r" (temp));
  //*ptr=*a+*ptr;

  while(1){
	  for (int i=-100;i<100;i++){
	    }
	  led(gpio,0x45);
	  for (int i=0;i<200;i++){
	    }
	  led(gpio,0x76);
	  for (int i=0;i<300;i++){
	    }
	  led(gpio,0xe3);
  }
}

void led(int* gpio,int val){
  *gpio=val;
}