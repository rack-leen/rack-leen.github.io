#! /usr/bin/lua

-- 程序块

x = 10 -- 定义一个全局变量

local  i = 1 -- 定义一个局部变量

while i < x do -- 这里是用全局变量x循环
    local x = i*10 --这里重新定义一个局部变量x
    print("test" .. i .. "  " .. x) -- 打印局部变量x
    i = i+1
end

if i > 20 then
    -- body
    local x 
    x = 20
    print(x+2) -- 打印if肯定程序块中的局部变量x
else 
    -- body
    print(x) -- 这里没有局部变量，因此打印全局变量
end

print(x)