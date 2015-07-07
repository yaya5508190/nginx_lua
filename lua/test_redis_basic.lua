local function close_redis(red)  
    if not red then  
        return  
    end
   ----关闭red连接  
   --local ok, err = red:close()  
   --if not ok then  
   --    ngx.say("close redis error : ", err)  
   --end
    --连接池模式
    local pool_max_idle_time = 10000 --毫秒  
    local pool_size = 100 --连接池大小  
    local ok, err = red:set_keepalive(pool_max_idle_time, pool_size)  
    if not ok then  
        ngx.say("set keepalive error : ", err)  
    end  
end  
  
local redis = require("resty.redis")  
  
--创建实例  
local red = redis:new()  
--设置超时（毫秒）  
red:set_timeout(1000)  
--建立连接  
local ip = "127.0.0.1"  
local port = 6660  
local ok, err = red:connect(ip, port)  
if not ok then  
    ngx.say("connect to redis error : ", err)  
    return close_redis(red)  
end  
--调用API进行处理  
ok, err = red:set("msg", "hello world")  
if not ok then  
    ngx.say("set msg error : ", err)  
    return close_redis(red)  
end  
  
--调用API获取数据  
local resp, err = red:get("msg")  
if not resp then  
    ngx.say("get msg error : ", err)  
    return close_reedis(red)  
end  
--得到的数据为空处理  
if resp == ngx.null then  
    resp = ''  --比如默认值  
end

ngx.say("msg : ", resp,"<br/>")  

red:init_pipeline()  
red:set("msg1", "hello1")  
red:set("msg2", "hello2")  
red:get("msg1")  
red:get("msg2")  
local respTable, err = red:commit_pipeline()  
  
--得到的数据为空处理  
if respTable == ngx.null then  
    respTable = {}  --比如默认值  
end  
  
--结果是按照执行顺序返回的一个table  
for i, v in ipairs(respTable) do  
   ngx.say("msg : ", v, "<br/>")  
end

local sha1, err = red:script("load",  "return redis.call('get', ARGV[1])");  
if not sha1 then  
   ngx.say("load script error : ", err)  
   return close_redis(red)  
end  
ngx.say("sha1 : ", sha1, "<br/>")  
local resp, err = red:evalsha(sha1, 0, "msg");

ngx.say("msg :",resp)  
close_redis(red)  
