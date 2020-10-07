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
#include "gpio.h"
#define APP_START 0x0080000
void led(int* gpio,int val);

int main()
{
  //int gpio;
  int *gpio;
  int *uart;
 
  gpio =gpio_init(1);
  uart =uart_init(1);
  uart_set_baud(uart,9600,50000000);
  led(gpio,0x86);
 	uart_print(uart,"AUK-V says Hiiiii!\r\n");
  wait_ms(10);
 	uart_print(uart,"Checking boot mode\r\n");
  wait_ms(10);
 	uart_print(uart,"UART boot selected\r\n");
  wait_ms(10);
 	uart_print(uart,"Loading Image......\r\n");
  wait_ms(10);
 	uart_print(uart,"Booting........\r\n");
  wait_ms(10);
  while (1){
    if(uart_data_ready(uart)==1){
      rx_data=uart_rx(uart);
      uart_tx(uart,rx_data);
    }
  }
  //while(1){
  
  		//
  	//uart_tx(uart,0xff);
	  //for (int i=-10;i<500000;i++){
	  //  }
	  //led(gpio,0x45);
  	//uart_tx(uart,0x31);
	  //for (int i=0;i<700000;i++){
	  //  }
	  //led(gpio,0x76);
  	//uart_tx(uart,0x11);
	  //for (int i=0;i<800000;i++){
	  //  }
	  //led(gpio,0xe3);
  //}
}

void led(int* gpio,int val){
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
