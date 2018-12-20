-- Copyright (C) 2018 by chrono

-- $backend_addr, $backend_port
-- we also could use ngx_http_lua_upstream
--local backend_addr = ngx.var.backend_addr or "127.0.0.1"
--local backend_port = tonumber(ngx.var.backend_port or 707)
local backend_addr = "127.0.0.1"
local backend_port = 707

local args = ngx.var.args or ""

local sock = ngx.socket.tcp()

local ok, err = sock:connect(backend_addr, backend_port)

if not ok then
    ngx.say("failed to connect : ", err)
    return
end

local bytes, err = sock:send(args .. '\n')

if err then
    ngx.say("failed to send : ", err)
    return
end

local data, err = sock:receive("*l")

if not data or err then
    ngx.say("failed to receive : ", err)
    return
end

ngx.say("received : ", data)

