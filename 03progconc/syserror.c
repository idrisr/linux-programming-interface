/* #include <stdlib.h> */
/* #include <stdio.h> */
#include <fcntl.h>
/* #include <errno.h> */
#include "tlpi_hdr.h"

int main() {
    int fd = open("/etc/nixos", 1, O_DIRECTORY);
    if (fd == -1) {
        if (errno == 21)  {
            printf("if\n");
        } else {
            printf("else\n");
        }
        printf("errno: %d\n", errno);

        printf("FAIL!\n");
    }
    return EXIT_SUCCESS;
}
