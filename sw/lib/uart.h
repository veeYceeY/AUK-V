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


