#! /usr/bin/lua

a = {}   -- 创建一个table，并将它的引用存储到a中
k = "color"  -- k是一个变量
a[k] = "green" -- 这里k作为a的key , key = k = "color"
print(a[k])    -- 这里打印的是key为"k"的value
a[9] = "great" -- a中key=9的value=great
print(a[9])   -- 这里打印出key=9的value
a["num"] = 10  -- key="num"的value=10
print(a["num"]) 

k = 9  -- 这里变量k的值更改

print(a[k]) -- 打印的是key=k=9的value=great

a["num"] = a["num"]+1 
print(a["num"])

a["x"] = 10 -- table a 的key="x"的value=10
b = a   -- 创建table b , table a 将自己赋值给table b
print(b["x"]) -- 现在从table b 能获取table a的所有变量
b["x"] = 20  -- table b 的key有更改，table a也会一起更改
print(a["x"])
a = nil -- table a 被回收 ， 现在只有table b 被引用
b = nil -- table b 被回收， 再也没有对table的引用