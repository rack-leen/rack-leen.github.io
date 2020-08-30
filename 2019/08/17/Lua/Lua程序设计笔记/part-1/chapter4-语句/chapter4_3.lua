#! /usr/bin/lua

local a , b = 1 , 10

if a < b then
    -- body
    print(a) -- 这里打印开始定义的局部变量a
    local a    -- 定义一个内部局部变量a
    print(a)  -- 打印内部局部变量a
end

print(a , b)  -- 这里的a , b 打印的是最外边的局部变量a , b


foo = 1   -- 定义一个全局变量
local foo = foo -- 将一个全局变量的值赋值给局部变量，作为局部变量的初值
print(foo)