#! /usr/bin/lua

i = 10 ; j = "10" ; k = "+10"

a = {}
a[i] = "one value"
a[j] = "another value"
a[k] = "yet another value"

print(a[i])
print(a[j])
print(a[tonumber(j)]) --将字符串"10"转换为数字10
print(a[tonumber(k)]) -- 将"+10"转换为数字10