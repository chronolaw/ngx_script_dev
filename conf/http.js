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

// echo string
function echo(r)
{
    var str = "hello nginx\n";

    if (r.method != 'GET') {
        r.return(401);
    }

    var args = r.variables.args;

    var len = str.length;

    if (args.length > 0) {
        len += 1 + args.length;
        str = args + ',' + str;
    }

    r.error("send '" + str + "'");

    r.status = 200;
    r.headersOut['Content-Length'] = len;
    r.sendHeader();

    r.send(str);
    r.finish();
}

// subrequest
function subrequest(r)
{
    var uri = "/inter";

    r.subrequest(uri,
        {args:r.variables.args},
        function(sr) {
            sr.error("sub body is " + sr.responseBody);

            sr.parent.return(
                sr.status,
                "hello " + sr.responseBody);
        });
}

// a/b testing
function split_clients(r)
{
    var now = new Date();
    if (now.getHours() < 16) {
        //r.error("split to a in " + now.getHours());
        return "upstream_a";
    }

    var ip_nums = r.remoteAddress.split('.');

    if (ip_nums[3] <= 70) {
        return "upstream_b";
    }

    return "upstream_a";
}
