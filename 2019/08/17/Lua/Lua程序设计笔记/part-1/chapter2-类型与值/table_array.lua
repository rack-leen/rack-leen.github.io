#! /usr/bin/lua

a = {}
a[1000] = 1 -- 这个数组是有空隙的数组，只有索引1000有值，其他的都没有值。不能用"#"
print(table.maxn(a)) -- table.maxn()返回这个table最大正索引数 lua5.1中使用

b = {}
for i=1,10 do  -- 这个table 10个索引都有值，这个就是没有空隙的数组
    b[i]=i*2
end
print(#b)   -- 返回这个数组长度
