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
// Demonstrate how to print a greeting message on standard output
// and exit.
//
// WARNING: This is a build-only project. Do not try to run it on a
// physical board, since it lacks the device specific startup.
//

int main()
{
 // cout << "Hello RISC-V World!" << endl;
  //int gpio;
  int *gpio;
  int *a,*b,*c;
  a=(int*)0x40;
  b=(int*)0x44;
  c=(int*)0x48;
  *a=5;
  *b=10;
  *c=*a+*b;
  gpio =(int*)4097;
  *gpio=0x86;

  //*ptr=*a+*ptr;

  while(1){
	  for (int i=0;i<200000;i++){
	    }
	  *gpio=0x45;
	  for (int i=0;i<200000;i++){
	    }
	  *gpio=0x76;
	  for (int i=0;i<200000;i++){
	    }
	  *gpio=0xe3;
  }
}
