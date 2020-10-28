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
#include "uart.h"
#include "time.h"
//#define APP_START 0x0080000
void led(volatile int* gpio,int val);

int main()
{
  //int gpio;
  volatile int *gpio;
  volatile int *uart;
  int *a,*b,*c;
  int x,y,z;
  int rx_data;
  a=&z;
  b=&y;
  c=&x;
  //a=(int*)0x00010110;
  //b=(int*)0x00010114;
  //c=(int*)0x00010118;
  *a=5;
  *b=-10;
  *c=(*a)-(*b);
  gpio =(int*) 0x00100004;
  uart =uart_init(1);
  uart_set_baud(uart,9600,50000000);
  //uart[0]=0x00000002;
  register uint32_t temp = 0x86;
  register uint32_t temp2 = 0x84;
  asm volatile("csrs mie, %[temp]\n":: [temp] "r" (temp));
  asm volatile("csrc mie, %[temp2]\n":: [temp2] "r" (temp2));
  //temp = 0x84;
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  //asm volatile("nop\n");
  *gpio=0x86;
  led(gpio,0x86);
 	uart_print(uart,"AUK-V says Hiiiii!\r\n");
  //wait_ms(10);
 	//uart_print(uart,"Checking boot mode\r\n");
  //wait_ms(10);
 	//uart_print(uart,"UART boot selected\r\n");
  //wait_ms(10);
 	//uart_print(uart,"Loading Image......\r\n");
  //wait_ms(10);
 	//uart_print(uart,"Booting........\r\n");
  //wait_ms(10);
  while (1){
    if(uart_data_ready(uart)==1){
      rx_data=uart_rx(uart);
      uart_tx(uart,rx_data);
      if (rx_data=='r') {
        led(gpio,0x06);
      }else if(rx_data=='g') {
        led(gpio,0x05);
      }else if(rx_data=='b') {
        led(gpio,0x03);
      }
    }
  }


/*
  while(1){
  
  	uart_tx(uart,0x41);
	  for (int i=-10;i<500000;i++){
	    }
	  led(gpio,0x45);
  	uart_tx(uart,0x42);
	  for (int i=0;i<70000;i++){
	    }
	  led(gpio,0x76);
  	uart_tx(uart,0x43);
	  for (int i=0;i<80000;i++){
	    }
	  led(gpio,0xe3);
  }
  */
}

void led(volatile int* gpio,int val){
  *gpio=val;
}
void exception_handler(uint32_t cause, void * epc, void * saved_sp)
{
	
}
/*
int __mulsi3(int a,int b){
	int i=0,y=0;
	for (i=0;i<a;i++){
		y+=b;
	}
	return y;
}
int __divsi3(int a,int b){
	int i=0,y=0;
	if(b==0){
		return 0;
	}
	
	for (i=a;i>0;i-=b){
		y++;
	}
	return y;
}
*/
