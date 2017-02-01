#include "whereami.h"
#include <stdlib.h>
#include <lua.h>
#include <lauxlib.h>

int lua_whereami(lua_State *L) {
    int length = 0;
    int dirname_length = 0;
    char *path;

    length = wai_getExecutablePath(NULL,0,&dirname_length);
    path = (char*)lua_newuserdata(L, length + 1);
    if(!path) {
        lua_pushnil(L);
        lua_pushnil(L);
        return 2;
    }
    wai_getExecutablePath(path,length,&dirname_length);
    path[length] = '\0';
    lua_pushstring(L,path);
    lua_pushnil(L);
    return 2;
}

int luaopen_whereami_core(lua_State *L) {
    lua_pushcfunction(L,lua_whereami);
    return 1;
}
