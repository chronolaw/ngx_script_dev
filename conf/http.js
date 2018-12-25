// Copyright (C) 2018 by chrono

// a array
var strs = ['hello', 'nginx', 'nginScript'];

// test log
function test_log(r)
{
    r.log("info levelmessage");
    r.error("hello Nginx JavaScript");

    return "hello JavaScript";
}

// test var
function test_var(r)
{
    var v = r.variables.nginx_version;
    var addr = r.variables['remote_addr'];

    r.error("var is " + v + ", " + addr);

    return "hello variables";
}

