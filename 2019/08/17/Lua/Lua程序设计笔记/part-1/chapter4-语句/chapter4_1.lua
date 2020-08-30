#! /usr/bin/lua

-- 修改变量的值

a = "hello" .. "world"  
print(a)

-- 修改table的值
t = {}
t.n = 1  -- 为table中的key=n赋值value=1
t.n = t.n+1 -- 自动+1
print(t.n) -- 打印出table中key对应的value

-- 多重赋值

c ,d = 10 , 20 -- 一次性给c 和d赋值
print(c , d)

x , y = 100 , 200 -- 先赋值给x,y
x,y = y,x -- 再将x和y的值对换
print(x,y)

e,f,g = 1,2 --三个变量只赋值两个，默认是从左往右赋值。如果要初始化一组变量，应该为每个变量提供一个值
print(e,f,g)