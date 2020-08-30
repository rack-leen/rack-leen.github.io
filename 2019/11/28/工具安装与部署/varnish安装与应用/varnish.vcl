vcl 4.0;

import directors;
import std ;

# 访问控制，能清理varnish缓存的角色
acl purge {
    "127.0.0.1";
    "localhost";
    "10.25.151.71";
}

backend default{
    .host = "127.0.0.1";
    .port = "80";
}

# 需要请求的目标服务器
backend guardStatic148185 {
    .host = "10.25.148.185";
    .port = "18061";
}
backend guardStatic148186 {
    .host = "10.25.148.186";
    .port = "18061";
}

# 轮询
sub vcl_init {
    new bar = directors.round_robin();
    bar.add_backend(guardStatic148185);
    bar.add_backend(guardStatic148186);
}

# 接收请求
sub vcl_recv {
    #set req.url = req.http.pureurl ;
    set req.backend_hint = bar.backend() ; # 负载均衡
    #return (synth(405 , req.http.pureurl));


    if (req.method == "PURGE") { # 清理缓存
        if (!client.ip ~ purge) { # 如果不是purge中的ip,不能清理缓存
            return (synth(405 , "This IP is not allowed to send PURGE requests."));
        }

        return (purge) ;
    }

    # 如果请求方法不是GET或者PURGE,直接返回错误，不被允许访问
    if (req.method != "GET" &&
		req.method != "PURGE") {
        return (synth(405 , "This method is not allowed."));
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
    hash_data(req.url); 
	# 如果有header中有host，则将host增加到hash中进行运算,得出唯一值
	if (req.http.host) {
		hash_data(req.http.host)
	}else{ # 如果没有，则使用请求的服务器ip增加到hash中进行运算，得出唯一值
		hash_data(server.ip)
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

# 这个函数可以设置缓存生命周期（这个函数是响应backend服务器，如果命中varnish缓存，就不会执行）
sub vcl_backend_response {
	# beresp.ttl 生命周期小于0的不缓存
	# beresp.http.Set-Cookie 设置了cookie的不缓存
	# beresp.http.businesscode 未命中的不缓存
	# beresp.http.logId 用户接口不缓存
	# beresp.status 错误状态码不缓存
    if (beresp.ttl <= 0s || beresp.http.Set-Cookie || beresp.http.Vary == "*" || beresp.http.businesscode == "000001" || beresp.http.logId == "userUrl" || beresp.status ~ "^[4,5]*") {
        set beresp.ttl = 120s ;
        set beresp.uncacheable = true ; # 设置不缓存
        return (deliver) ;
    }else{ 
        set beresp.ttl = 1h ; # 返回码不是000001，表示访问到正确的接口，拉取的数据缓存1h
    }

    set beresp.grace = 1h;

    return (deliver) ;
}

# 客户端接收（这里需要给一个状态码，得知数据是从varnish或者backend服务器拉取的）
sub vcl_deliver {
    if (obj.hits > 0) { # 如果命中缓存次数大于0，表示varnish中有该请求的缓存，直接使用缓存
		set beresp.http.businesscode = "000009" ; # 如果命中，将businsscode替换
        set resp.http.X-Cache = "Cache" ;
    }else { # 否则就从目标服务器拉取数据
        set resp.http.X-Cache = "UnCache" ;
    }

    return (deliver) ; # 最终返回客户端
}