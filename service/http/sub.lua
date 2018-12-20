-- Copyright (C) 2018 by chrono 

--local uri = '/access'
--local uri = '/allow'
local uri = '/deny'

local res = ngx.location.capture(
                uri,
                {args=ngx.var.args})


ngx.log(ngx.ERR, "subreqeust body is ", res.body)

if res.status ~= ngx.HTTP_OK then
    ngx.exit(res.status)
end
