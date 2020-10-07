
#define GPIO_WRITE 0

int* goio_init(int id){
    if (id=='1'){
        return 0x00100001;
    }
}

void gpio_write(int* dev,int data){
    dev[GPIO_WRITE]=data;
}