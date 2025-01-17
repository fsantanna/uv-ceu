include Makefile.conf

CEU_ARGS ?=
CEU_SRC  ?= samples/tcp-01.ceu

all:
	ceu $(SRC).ceu -cc "-g -lm -luv -include uv.h"

LUA_FLAGS = -llua5.3

samples:
	for i in samples/async-*.ceu	\
	         samples/timer-*.ceu	\
	         samples/threads-*.ceu	\
	         samples/fs-*.ceu       \
	         samples/tcp-*.ceu;	    \
	do								\
	    echo;                                                               \
	    echo "#########################################################";   \
	    echo File: "$$i -> /tmp/$$(basename $$i .ceu)";                     \
	    echo "#########################################################";   \
	    echo -n "Press <enter> to start...";                                \
	    read _;                                                             \
	    ceu --pre --pre-args="-I$(CEU_DIR)/include -I./include -I./samples/" \
	              --pre-input=$$i                                           \
	        --ceu --ceu-features-lua=true --ceu-features-thread=true --ceu-features-trace=true --ceu-features-exception=true --ceu-err-unused=pass --ceu-err-uninitialized=pass \
	              --ceu-features-dynamic=true --ceu-features-pool=true \
	              --ceu-features-os=true --ceu-features-async=true \
	        --env --env-types=$(CEU_DIR)/env/types.h                        \
	              --env-threads=./env/threads.h                             \
	              --env-main=$(CEU_DIR)/env/main.c                          \
	              --env-output=/tmp/x.c                   \
	        --cc --cc-args="$(LUA_FLAGS) -luv $(CC_ARGS)"                   \
	             --cc-output=/tmp/$$(basename $$i .ceu);                    \
	    cd samples && /tmp/$$(basename $$i .ceu) ; cd ..                    \
	    echo ">>> OK";                                                      \
	    echo;                                                               \
	    echo;                                                               \
	    echo;                                                               \
	    echo;                                                               \
	    echo;                                                               \
	    echo;                                                               \
	done

.PHONY: samples
