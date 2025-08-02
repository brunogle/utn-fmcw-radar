#include <stdio.h>
#include <unistd.h>
#include <stdint.h>
#include <stdlib.h>
#include <fcntl.h>
#include <termios.h>
#include <sys/mman.h>
#include <string.h>
#include <sys/ioctl.h>
#include <math.h>

#define DMA_SIZE 0x80000 //512KB (262144 16bit samples)

#define BRAM_ADDR 0x40000000
#define BRAM_SIZE 0x8000

#define SWEEP_CFG_ADDR 0x60000000
#define SWEEP_CFG_SIZE 0x8000
#define SWEEP_CFG_START      0x0
#define SWEEP_CFG_CLK_DIV    0x4
#define SWEEP_CFG_MAX_ADDR   0x8

#define DMA_CFG_ADDR 0x40400000
#define DMA_CFG_SIZE 0x10000
#define DMA_CFG_MM2S_DMACR        0x00
#define DMA_CFG_MM2S_DMASR        0x04
#define DMA_CFG_MM2S_CURDESC      0x08
#define DMA_CFG_MM2S_CURDESC_MSB  0x0C
#define DMA_CFG_MM2S_TAILDESC     0x10
#define DMA_CFG_MM2S_TAILDESC_MSB 0x14
#define DMA_CFG_MM2S_SA           0x18
#define DMA_CFG_MM2S_SA_MSB       0x1C
#define DMA_CFG_MM2S_LENGTH       0x28
#define DMA_CFG_SG_CTL            0x2C
#define DMA_CFG_S2MM_DMACR        0x30
#define DMA_CFG_S2MM_DMASR        0x34
#define DMA_CFG_S2MM_CURDESC      0x38
#define DMA_CFG_S2MM_CURDESC_MSB  0x3C
#define DMA_CFG_S2MM_TAILDESC     0x40
#define DMA_CFG_S2MM_TAILDESC_MSB 0x44
#define DMA_CFG_S2MM_DA           0x48
#define DMA_CFG_S2MM_DA_MSB       0x4C
#define DMA_CFG_S2MM_LENGTH       0x58

#define WR_REG_32(address, offset, value)    (*((uint32_t *)((address) + (offset))) = (value))
#define RD_REG_32(address, offset)           (*((uint32_t *)((address) + (offset))))
#define WR_REG_16(address, offset, value)    (*((uint16_t *)((address) + (offset))) = (value))
#define RD_REG_16(address, offset)           (*((uint16_t *)((address) + (offset))))
#define WR_REG_8(address,  offset, value)    (*((uint8_t *)((address) + (offset))) = (value))
#define RD_REG_8(address,  offset)           (*((uint8_t *)((address) + (offset))))


void * map_device(size_t base_addr, size_t size){
    int fd;
    char *name = "/dev/mem";
    void *map;

    if((fd = open(name, O_RDWR)) < 0) {
        perror("open");
        return NULL;
    }

    map = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, base_addr);
    if(map == NULL){
        close(fd);
        perror("mmap");
        return NULL;
    }

    close(fd);

    return map;
}

int unmap_device(void *map, size_t size){
    if (munmap(map, size) == -1) {
        perror("munmap");
        return -1;
    }
    return 0;
}

void * map_dma_mem(uint32_t size, uint32_t * dma_phys_addr){

    uint32_t dma_phys_addr_return;
    int fd;

    if((fd = open("/dev/cma", O_RDWR)) < 0){
        perror("open");
        return NULL;
    }

    dma_phys_addr_return = size;
    if(ioctl(fd, _IOWR('Z', 0, uint32_t), &dma_phys_addr_return) < 0){
        perror("ioctl");
        return NULL;
    }

    void * dma_addr = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

    if(dma_addr == NULL){
        close(fd);
        perror("mmap");
        return NULL;
    }

    close(fd);

    *dma_phys_addr = dma_phys_addr_return;

    return dma_addr;
}

int write_sweep_function(float * arr, uint32_t size, void * bram_map){

    for(int i = 0; i < size; i++){

        float f = arr[i];
        uint16_t dac_val;

        if (f >= 1.0f){
            dac_val = 0x1FFF;
        }
        else if (f <= -1.0f){
            dac_val = 0x2000;
        }
        else{
            dac_val = (int16_t)(f * 8192.0f);
            dac_val |= (dac_val < 0) ? 0x2000 : 0x0;
            dac_val &= 0x3fff;
        }


        WR_REG_16(bram_map, i<<1, dac_val);
    }
}

void memdump(int * virtual_address, int byte_count) {
    int offset;
    /*for (offset = 0; offset < byte_count; offset++) {
     *        printf("%02x", p[offset]);
     *        if (offset % 4 == 3) { printf(" "); }
}*/
    for (offset = 0; offset < byte_count/4; offset++) {

        printf("%08x ", virtual_address[offset]);
    }
    printf("\n");
}

void memdump16(void * virtual_address, int byte_count) {
    int offset;
    /*for (offset = 0; offset < byte_count; offset++) {
     *        printf("%02x", p[offset]);
     *        if (offset % 4 == 3) { printf(" "); }
}*/
    for (offset = 0; offset < byte_count; offset+=2) {

        printf("%04x ", RD_REG_16(virtual_address, offset));
    }
    printf("\n");
}

void dma_s2mm_status(void* dma_cfg_map) {
    unsigned int status =  RD_REG_32(dma_cfg_map, DMA_CFG_S2MM_DMASR);
    printf("Stream to memory-mapped status (0x%08x@0x%02x):", status, DMA_CFG_S2MM_DMASR);
    if (status & 0x00000001) printf(" halted"); else printf(" running");
    if (status & 0x00000002) printf(" idle");
    if (status & 0x00000008) printf(" SGIncld");
    if (status & 0x00000010) printf(" DMAIntErr");
    if (status & 0x00000020) printf(" DMASlvErr");
    if (status & 0x00000040) printf(" DMADecErr");
    if (status & 0x00000100) printf(" SGIntErr");
    if (status & 0x00000200) printf(" SGSlvErr");
    if (status & 0x00000400) printf(" SGDecErr");
    if (status & 0x00001000) printf(" IOC_Irq");
    if (status & 0x00002000) printf(" Dly_Irq");
    if (status & 0x00004000) printf(" Err_Irq");
    printf("\n");
}

int dma_s2mm_sync(void* dma_cfg_map) {
    unsigned int s2mm_status = RD_REG_32(dma_cfg_map, DMA_CFG_S2MM_DMASR);

    while(!(s2mm_status & 1<<12) || !(s2mm_status & 1<<1)){
        s2mm_status = RD_REG_32(dma_cfg_map, DMA_CFG_S2MM_DMASR);
    }
}

void dma_s2mm_start(void * dma_cfg_map, uint32_t phys_addr, uint32_t max_length){
    WR_REG_32(dma_cfg_map, DMA_CFG_S2MM_DMACR, 0x4);
    WR_REG_32(dma_cfg_map, DMA_CFG_S2MM_DMACR, 0x0);
    WR_REG_32(dma_cfg_map, DMA_CFG_S2MM_DMACR, 0xf001);
    WR_REG_32(dma_cfg_map, DMA_CFG_S2MM_DA, phys_addr);
    WR_REG_32(dma_cfg_map, DMA_CFG_S2MM_LENGTH, max_length);
}

void write_samples(const char *filename, void *dma_map, uint32_t sample_size) {
    FILE *fp = fopen(filename, "w");
    if (!fp) {
        perror("Failed to open file");
        return;
    }

    for (size_t i = 0; i < sample_size; ++i) {
        if (fprintf(fp, "%d\n", (int16_t)RD_REG_16(dma_map, i<<1)) < 0) {
            perror("Failed to write sample");
            break;
        }
    }

    fclose(fp);
}


int main(int argc, char **argv){
    void * bram_map = map_device(BRAM_ADDR, BRAM_SIZE);
    void * sweep_cfg_map = map_device(SWEEP_CFG_ADDR, SWEEP_CFG_SIZE);
    void * dma_cfg_map = map_device(DMA_CFG_ADDR, DMA_CFG_SIZE);

    uint32_t phys_dma = 0;
    void * dma_map = map_dma_mem(DMA_SIZE, &phys_dma);

    memset(dma_map, 0, DMA_SIZE);
    memset(bram_map, 0, BRAM_SIZE);

    const int sample_size = BRAM_SIZE/2;

    float arr[sample_size];

    for(int i = 0; i < sample_size; i++){
        arr[i] = sin(100*3.14159265f*(float)i/sample_size);
    }

    write_sweep_function(arr, sample_size, bram_map);

    WR_REG_32(sweep_cfg_map, SWEEP_CFG_MAX_ADDR, sample_size);
    WR_REG_32(sweep_cfg_map, SWEEP_CFG_CLK_DIV, 0);

    dma_s2mm_start(dma_cfg_map, phys_dma, DMA_SIZE);

    WR_REG_8(sweep_cfg_map, SWEEP_CFG_START, 1);

    dma_s2mm_sync(dma_cfg_map);

    write_samples("adc_samples.txt", dma_map, sample_size);

    unmap_device(bram_map, BRAM_SIZE/2);
    unmap_device(sweep_cfg_map, SWEEP_CFG_SIZE);
    unmap_device(dma_cfg_map, DMA_CFG_SIZE);
    unmap_device(dma_map, DMA_SIZE);

    return 0;
}

