#include <math.h> 
#include "lua.h" 
#include "lualib.h" 
#include "lauxlib.h" 

static int l_sin (lua_State *L)  
{ 
double d = luaL_checknumber(L, 1); 
lua_pushnumber(L, sin(d)); 
return 1; /* number of results */ 
} 

static const struct luaL_reg mylib [] = { 
{"lsin", l_sin}, 
{NULL, NULL} /* 必须以NULL结尾 */ 
}; 

int luaopen_mylib (lua_State *L)  
{ 
luaL_register(L, "mylib1", mylib); 
return 1; 
} 
