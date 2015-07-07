local module1 = require("module1")
local uri_args = ngx.req.get_uri_args()

--pcall 是lua的异常处理机制 两个返回值 第一个返回是否存在异常 第二个当正确时为函数的返回值 出现异常时为异常的位置
local status,result = pcall(module1.hello,uri_args.a)
if(status) then
ngx.say(result)
else
ngx.say("error")
end
