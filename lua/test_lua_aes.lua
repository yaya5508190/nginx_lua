local aes = require "resty.aes"
local str = require "resty.string"

local uri_args = ngx.req.get_uri_args()  

local key = uri_args["key"] or "mykey"
local content = uri_args["content"] or "content"

local aes_128_cbc_md5 = aes:new(key)
-- the default cipher is AES 128 CBC with 1 round of MD5
-- for the key and a nil salt
local encrypted = aes_128_cbc_md5:encrypt(content)
local hex = str.to_hex(encrypted)
ngx.say("AES 128 CBC (MD5) Encrypted HEX: ", hex, "</br>")
ngx.say("AES 128 CBC (MD5) Decrypted: ", aes_128_cbc_md5:decrypt(encrypted), "</br>")
ngx.say("encrypted: ", encrypted, "</br>")
ngx.say("hexToBin ", hexutils1.hex_to_str(#hex,hex) ,"</br>")
