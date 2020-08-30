#! /usr/bin/lua

a = math.pi; b = 20 
print(a%b == a-math.floor(a/b)*b ) 
print(a-a%1) -- 取整数部分
print(a-a%0.01) -- 精确到两位小数