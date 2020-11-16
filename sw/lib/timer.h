#define TM_STATUS 0x00
#define TM_CTRL 0x01
#define TM_COUNT 0x02

int* timer_init(int id);

void timer_set_count(volatile int* dev, int count);

void timer_enable(volatile int* dev);
void timer_disable(volatile int* dev);
void timer_start(volatile int* dev);
void timer_stop(volatile int* dev);

int timer_overflow(volatile int* dev);




int* timer_init(int id){
	if (id == 1) {
		return (int*) 0x00100200;
	}else{
		return 0;
	}
}
int timer_overflow(volatile int* dev){
  if ((dev[TM_STATUS] & 0x01)==1 ){
    return 0;
  }else{
    return 1;
  }
}
void timer_set_count(volatile int* dev, int count){
	
	dev[TM_COUNT]= count;
}

void timer_enable(volatile int* dev){
	 dev[TM_CTRL]=dev[TM_CTRL] | 0x00000001;
}
void timer_disable(volatile int* dev){
	 dev[TM_CTRL]=dev[TM_CTRL] | 0xfffffffE;
}

void timer_start(volatile int* dev){
	dev[TM_CTRL]=0x0000000f;
}


void timer_stop(volatile int* dev){
	dev[TM_CTRL]=dev[TM_CTRL] & 0xfffffff0;
}


