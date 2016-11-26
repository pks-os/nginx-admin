user  nginx;
worker_processes  1;

error_log  &base&/log/error.log warn;
pid        &base&/process/nginx.pid;

events {
    worker_connections  1024;
}


http {
    include       &base&/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  &base&/log/access.log  main;

    sendfile        on;
    keepalive_timeout  65;
    
    include  &base&/upstream/*.conf;
    include  &base&/virtual-domain/*.conf;
}