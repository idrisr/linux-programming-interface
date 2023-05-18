#include <gnu/libc-version.h>
#include "tlpi_hdr.h"

int
main(int argc, char *argv[]) {
    printf("%s\n", gnu_get_libc_version());
    exit(EXIT_SUCCESS);
}
