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


void exception_handler(uint32_t cause, void * epc, void * saved_sp);




int main()
{
  //int gpio;
  int *gpio;
  int *a,*b,*c;
  int x,y,z;
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
  led(gpio,0x86);

  register uint32_t temp = 0x86;
  register uint32_t temp2 = 0x84;
  asm volatile("csrs mie, %[temp]\n":: [temp] "r" (temp));
  asm volatile("csrc mie, %[temp2]\n":: [temp2] "r" (temp2));
  //temp = 0x84;
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  //*ptr=*a+*ptr;

  while(1){
	  for (int i=-100;i<500;i++){
	    }
	  led(gpio,0x45);
	  for (int i=0;i<700;i++){
	    }
	  led(gpio,0x76);
	  for (int i=0;i<600;i++){
	    }
	  led(gpio,0xe3);
  }
}

void led(int* gpio,int val){
  *gpio=val;
}


void exception_handler(uint32_t cause, void * epc, void * saved_sp)
{
	
}
