--用于解码aex
local aes = require "resty.aes"
local str = require "resty.string"

local uri_args = ngx.req.get_uri_args()  
local key = "qazxswa"
local uri = ngx.var.uri
ngx.log(ngx.ERR, uri)

local resultStrsList = {};
string.gsub(uri, '[^.]+', 
	     function(w)
	        table.insert(resultStrsList, w) 
	     end 
           );
ngx.log(ngx.ERR,resultStrsList[1])
local aes_128_cbc_md5 = aes:new(key)
-- the default cipher is AES 128 CBC with 1 round of MD5
-- for the key and a nil salt
local resulturi = aes_128_cbc_md5:decrypt(hexutils1.hex_to_str(#resultStrsList[1]-1,string.sub(resultStrsList[1],2)))..'.'..resultStrsList[2]
ngx.log(ngx.ERR,resulturi)
return resulturi
