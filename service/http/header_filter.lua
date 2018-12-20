-- Copyright (C) 2018 by chrono

local headers = {}
headers['x-name'] = 'chrono'
headers['x-value'] = 'trigger'

for k,v in pairs(headers) do
    ngx.header[k] = v
end

ngx.header.content_length = nil
