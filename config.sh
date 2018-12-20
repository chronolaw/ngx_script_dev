#!/bin/sh

ngx_path=${HOME}/nginx
src_path=${HOME}/github

prefix="--prefix=/opt/nginx_script"
build_date="${USER} build at `date '+%Y.%m.%d %H:%M'`"

modules="--with-stream
         --with-stream_ssl_module
        "

no_modules="--without-http_fastcgi_module
            --without-http_uwsgi_module
            --without-http_scgi_module
           "

njs="--add-module=${src_path}/njs/nginx"

# luajit : make PREFIX=/opt/lj2 install
export LUAJIT_LIB=/opt/lj2/lib
export LUAJIT_INC=/opt/lj2/include/luajit-2.1

#ld_opt="-Wl,-rpath,${LUAJIT_LIB}"

ndk_module="${src_path}/ngx_devel_kit"
http_lua_module="${src_path}/lua-nginx-module"
stream_lua_module="${src_path}/stream-lua-nginx-module"

ngx_lua="--add-module=${ndk_module}
         --add-module=${http_lua_module}
         --add-module=${stream_lua_module}"

opts="${prefix}
      ${modules}
      ${no_modules}
      ${njs}
      ${ngx_lua}
      "

cd $ngx_path

./configure     \
    --build="${build_date}" \
    --with-ld-opt="-Wl,-rpath,${LUAJIT_LIB}"   \
    ${opts}

cd -
