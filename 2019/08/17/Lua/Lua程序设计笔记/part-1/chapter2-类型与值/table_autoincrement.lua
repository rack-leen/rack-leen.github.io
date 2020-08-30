#! /usr/bin/lua

-- table是自动增长的

a = {}

-- 这使得table a的key从1自动增长到1000
for i=1,1000 do
    a[i] = i*2
end

print(a[9])  
a["x"] = 10  -- 在table a中创建一个新的key
print(a["x"]) -- 这个key在table a中存在
print(a["y"]) -- 这个key不存在
