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
int __mulsi3(int a,int b);
void led(int* gpio,int val);


void exception_handler(uint32_t cause, void * epc, void * saved_sp);

#define TXDATA 0x00
#define RXDATA 0x01
#define STATUS 0x02
#define BAUD   0x03
#define INTERRUPT 0x04

int* uart_init(int id);

void uart_set_baud(int* dev, int baud, int sys_freq);

int uart_rx(int* dev);

void uart_tx(int* dev,int data);
void uart_print(int* dev,const char* msg);

int uart_data_ready(int* dev);




int main()
{
  //int gpio;
  int *gpio;
  int *uart;
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
  gpio =(int*) 0x00100001;
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

int* uart_init(int id){
	if (id == 1) {
		return (int*) 0x00100100;
	}else{
		return 0;
	}
}
int uart_data_ready(int* dev){
  if ((dev[STATUS] & 0x01)==1 ){
    return 0;
  }else{
    return 1;
  }
}
void uart_set_baud(int* dev, int baud, int sys_freq){
	
	dev[BAUD]= 27;
}

int uart_rx(int* dev){
	return dev[RXDATA];
}

void uart_tx(int* dev,int data){
	dev[TXDATA]=data;
}


void uart_print(int* dev,const char* msg){
	for (int i=0;msg[i]!=0;i++){
	//for (int i=0;i<8;i++){
		uart_tx(dev,msg[i]);
	}
}

void exception_handler(uint32_t cause, void * epc, void * saved_sp)
{
	
}
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

