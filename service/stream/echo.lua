-- Copyright (C) 2018 by chrono

local sock = assert(ngx.req.socket())

-- 3 seconds
sock:settimeout(3000)

while true do
    local data, err = sock:receive(1)   -- 1bytes buffer

    if not data or err then
        ngx.log(ngx.ERR, "received error : ", err)
        ngx.exit(ngx.ERROR)
    end

    local ok, err = sock:send(data)
    if not ok or err then
        ngx.log(ngx.ERR, "send data error : ", err)
        ngx.exit(ngx.ERROR)
    end
end
