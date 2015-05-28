--未经解码的请求uri  
local request_uri = ngx.var.request_uri; 
local base64_request_uri; 
ngx.say("request_uri : ", request_uri, "<br/>");  
--解码  
ngx.say("decode request_uri : ", ngx.unescape_uri(request_uri), "<br/>");  
--MD5  
ngx.say("ngx.md5 : ", ngx.md5(request_uri), "<br/>")  
--BASE64
base64_request_uri = ngx.encode_base64(request_uri); 
ngx.say("ngx.encode_base64 : ", base64_request_uri , "<br/>")
ngx.say("ngx.decode_base64 : ", ngx.decode_base64(base64_request_uri) , "<br/>")
--http time  
ngx.say("ngx.http_time : ", ngx.http_time(ngx.time()), "<br/>") 
