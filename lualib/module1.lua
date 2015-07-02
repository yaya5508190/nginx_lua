local function hello(count)  
   count = count + 1
   ngx.say(count) 
end  
  
local _M = {  
   hello = hello  
}  
  
return _M
