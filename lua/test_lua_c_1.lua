local uri_args = ngx.req.get_uri_args()
local i = uri_args["i"] or 0
return hexutils1.lcos(i);
