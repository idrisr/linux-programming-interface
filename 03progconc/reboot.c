#include <stdio.h>
#include <linux/reboot.h>

int main(void) {
    long magics[4] = {
        LINUX_REBOOT_MAGIC2 ,
        LINUX_REBOOT_MAGIC2A,
        LINUX_REBOOT_MAGIC2B,
        LINUX_REBOOT_MAGIC2C
    };

    for (int i=0; i<4; i++) {
        printf("hex: %0lx dec: %lu\n", magics[i], magics[i]);
    }

    return 0;
}
