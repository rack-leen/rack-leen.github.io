--
--------------------------------------------------------------------------------
--         File:  base_type.lua
--
--        Usage:  ./base_type.lua
--
--  Description:  
--
--      Options:  ---
-- Requirements:  ---
--         Bugs:  ---
--        Notes:  ---
--       Author:  YOUR NAME (), <>
-- Organization:  
--      Version:  1.0
--      Created:  2019年08月17日
--     Revision:  ---
--------------------------------------------------------------------------------
--

print(type("Hello World !"))  -- string类型
print(type(10*3))             -- number类型
print(type(print))            -- function类型
print(type(type))             -- function类型
print(type(true))             -- boolean类型
print(type(nil))              -- nil类型
print(type(type(X)))          -- string类型(type最终返回的是一个字符串)

-- 设变量a
print(type(a))  -- 打印出的是nil类型
a = 10
print(type(a))  -- 打印的是number类型
a = "string"   
print(type(a))  -- 打印的是string类型
a = print       -- 这里可以将a看做函数print的别名
a(type(a))      -- 这里使用a表示使用print
