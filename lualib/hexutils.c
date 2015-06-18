#include <string.h> 
#include "lua.h" 
#include "lualib.h" 
#include "lauxlib.h" 

char AtoB( char c )
{
  if ( (c >= '0') && (c <= '9') )
  {
    return (( char ) (c - '0')) ;
  }
  if ( (c >= 'A') && (c <= 'F') )
  {
    return (( char ) (c - 'A' + 10)) ;
  }
  if ( (c >= 'a') && (c <= 'f') )
  {
    return (( char ) (c - 'a' + 10)) ;
  }
  return 0 ;
}

void strToBin( const char *str , char *bin,int len )
{
  while ( len > 0 )
  {
    if ( *str == '\0' )
    {
      return ;
    }
    if ( *(str + 1) == '\0' )
    {
      *bin = ( char ) ( unsigned char ) (AtoB( *str ) * 16) ;
      return  ;
    } ;
    *bin = ( char ) ( unsigned char ) (AtoB( *str ) * 16 + AtoB( *(str + 1) )) ;
    ++bin ;
    str += 2 ;
    len-- ;
  }

  return  ;
}

static int hex_to_str (lua_State *L)  
{ 
    int size = (int)luaL_checknumber(L, 1); 
    char data[size+1];
    char bdata[size/2+1];
    char cdata[size+1];

    memset(data,0,sizeof(data));
    memset(bdata,0,sizeof(bdata));
    memset(cdata,0,sizeof(cdata));
    
    strcat(cdata,luaL_checkstring(L, 2));
    strToBin(cdata,bdata,size/2);
    lua_pushstring(L, bdata); 
    return 1; /* number of results */ 
} 

static const struct luaL_reg hexutils [] = { 
{"hex_to_str", hex_to_str}, 
{NULL, NULL} /* 必须以NULL结尾 */ 
}; 

int luaopen_hexutils (lua_State *L)  
{ 
luaL_register(L, "hexutils1", hexutils); 
return 1; 
} 

