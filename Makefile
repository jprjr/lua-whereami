CC = gcc
AR = ar
RANLIB = ranlib
LUA = lua
LUA_LIBS = $(shell pkg-config --libs $(LUA))
LUA_CFLAGS = $(shell pkg-config --cflags $(LUA))

.PHONY: clean all

all: whereami/core.so whereami.a

whereami.a: whereami/src/whereami.o lua-whereami.o
	$(AR) rcs whereami.a lua-whereami.o whereami/src/whereami.o
	$(RANLIB) whereami.a

whereami/core.so: whereami/src/whereami.o lua-whereami.o
	$(CC) -shared $(LUA_LIBS) -o whereami/core.so lua-whereami.o whereami/src/whereami.o

whereami/src/whereami.o: whereami/src/whereami.c
	$(CC) -Wall -Wextra -fPIC -I./whereami/src -c whereami/src/whereami.c -o whereami/src/whereami.o

lua-whereami.o: lua-whereami.c
	$(CC) -Wall -Wextra -fPIC $(LUA_CFLAGS) -I./whereami/src -c lua-whereami.c -o lua-whereami.o

clean:
	rm -f whereami/src/whereami.o lua-whereami.o whereami.so whereami.a whereami/core.so
