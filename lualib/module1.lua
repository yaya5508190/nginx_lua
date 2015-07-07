local hello =  function(count)  
   count = count + 1
   return count
end  
  
local _M = {  
   hello = hello  
}  
  
return _M
