vcl 4.0;
import directors;
import std ;

# 访问控制，清理varnish缓存的角色
acl purge {
    "127.0.0.1";
    "localhost";
}

# 需要请求的目标服务器
backend default {
    .host = "";
    .port = "";
}

backend nginx1 {
    .host = "";
    .port = "";
}

backend nginx2 {
    .host = "";
    .port = "";
}

# 刚开始初始化的方法
sub vcl_init {
    new bar = directors.round_robin(); # 创建负载均衡的服务器组
    bar.add_backend(nginx1) ;
    bar.add_backend(nginx2) ;
}

# 接收请求
sub vcl_recv {
    set req.backend_hint = bar.backend() ; # 接收请求命中的服务器是bar组中的服务器

    if (req.method == "PURGE") { # 清理缓存
        if (!client.ip ~ purge) { # 如果不是本机，不能清理缓存
            return (synth(405 , "This IP is not allowed to send PURGE requests."));
        }

        return (purge) ;
    }

    # 如果不是这些方法，就使用pipe模式，直接与服务器连接,直到pipe连接关闭
    if (req.method != "GET" && 
            req.method != "HEAD" && 
            req.method != "PUT" && 
            req.method != "POST" && 
            req.method != "TRACE" &&
            req.method != "OPTIONS" &&
            req.method != "PATCH" &&
            req.method != "DELETE") {
                return (pipe) ;
            }
    
    # 如果请求方法不是GET和HEAD，就直接访问服务器拉取数据，因为GET和HEAD访问的比较频繁，而且获取的内容相同，需要做缓存
    if (req.method != "GET" && req.method != "HEAD") {
        return (pass) ;
    }

    # 如果请求的是大文件，就不要把它放到cookie里面了
    if (req.url ~ "^[^?]*\.(bmp|bz2|css|doc|eot|flv|gif|gz|ico|jpeg|jpg|js|less|pdf|png|rtf|swf|txt|woff|xml)(\?.*)?$") {
        unset req.http.Cookie ;
        # 先本地查询
        return (hash) ;
    }

    # 没有足够权限获取缓存，就直接拉取
    if (req.http.Authorization) {
        return (pass) ;
    }

    # 如果是上诉其他情况，请求之后，就进入本地查询
    return (hash) ;
}

# 管道直连，直到pipe关闭，连接才关闭
sub vcl_pipe {
    return (pipe) ;
}

# 将请求进行hash算法，得到唯一值
sub vcl_hash {
    hash_data(req.url); # 获取请求url的hash
    if (req.http.host) { # 如果请求的是域名
        hash_data(req.http.host);
    }else { # 否则直接使用主机ip
        hash_data(server.ip) ;
    }
    # 如果存在cookie
    if (req.http.Cookie) {
        hash_data(req.http.Cookie) ;
    }
}

# 命中varnish 中的缓存
sub vcl_hit {
    return (deliver) ; # 命中之后就直接返回给客户端
}

# 如果没有命中缓存
sub vcl_miss {
    return (fetch) ; # 如果没有缓存，就拉取服务器的数据
}

# 这个函数可以设置缓存生命周期
sub vcl_backend_response {
    # 如果被请求的是大文件
    if (bereq.url ~ "^[^?]*\.(bmp|bz2|doc|eot|flv|gif|gz|ico|jpeg|jpg|less|mp[34]|pdf|png|rar|rtf|swf|tar|tgz|txt|wav|woff|xml|zip)(\?.*)?$") {
        unset beresp.http.set-cookie ; # 取消设置缓存
        set beresp.ttl = 1h ; # 设置生命周期为1小时
    }

    # 如果请求的是静态文件
    if (bereq.url ~ "^[^?]*\.(css|js|html)(\?.*)?$") {
        set beresp.ttl = 10m ; # 设置生命周期为10分钟
    } 

    if (beresp.ttl <= 0s || beresp.http.Set-Cookie || beresp.http.Vary == "*") {
        set beresp.ttl = 120s ;
        set beresp.uncacheable = true ; # 设置不缓存
        return (deliver) ;
    }

    set beresp.grace = 1h;

    return (deliver) ;
}

# 客户端接收
sub vcl_deliver {
    if (obj.hits > 0) { # 如果命中缓存次数大于0，表示varnish中有缓存，直接使用缓存
        set resp.http.X-Cache = "Cache" ;
    }else { # 否则就从目标服务器拉取数据
        set resp.http.X-Cache = "UnCache" ;
    }

    return (deliver) ; # 最终返回客户端
}