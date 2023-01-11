#if 0
#!/bin/sh
gcc 02-default.c -o 02-default -l uv
exit
#endif

// http://docs.libuv.org/en/v1.x/guide/basics.html

#include <stdio.h>
#include <stdlib.h>
#include <uv.h>

int main() {
    uv_loop_t* loop = uv_default_loop();

    printf("Default loop.\n");
    uv_run(loop, UV_RUN_DEFAULT);

    uv_loop_close(loop);
    return 0;
}
