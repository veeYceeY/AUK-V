//============================================================================
// Name        : main.cpp
// Author      : veeYceeY
// Version     :
// Copyright   : Your copyright notice
// Description : Hello RISC-V World in C++
//============================================================================

//#include <iostream>
//using namespace std;


//
void led(int* gpio,int val);

int main()
{
  //int gpio;
  int *gpio;
  int *a,*b,*c;
  a=(int*)0x110;
  b=(int*)0x114;
  c=(int*)0x118;
  *a=5;
  *b=-10;
  *c=*a+*b;
  gpio =(int*)4097;
  *gpio=0x86;

  //*ptr=*a+*ptr;

  while(1){
	  for (int i=-100;i<200000;i++){
	    }
	  led(gpio,0x45);
	  for (int i=0;i<300000;i++){
	    }
	  led(gpio,0x76);
	  for (int i=0;i<000000;i++){
	    }
	  led(gpio,0xe3);
  }
}

void led(int* gpio,int val){
  *gpio=val;
}