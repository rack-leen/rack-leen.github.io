#! /usr/bin/lua

line = io.read() -- 从标准输入读取字符到line全局变量中
n = tonumber(line)  -- 将line变量中字符串转换为数字(如果字符串是字母，则返回nil,如果是实数，则返回number类型)

if n == nil then
    error(line .. "is not a vaild number")
else
    print(n*2)
end

s = tostring(n) -- 将一个数字转换为字符串

print(s == "10") 
print(10 .. "" == "10") -- 这样将10转换为字符串