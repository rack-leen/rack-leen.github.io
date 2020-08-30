#! /usr/bin/lua

a = "hello world"

print(#a)   -- 在变量名前面加"#"就能获取变量的长度，一般都是字符串
print(#"good\0bye")  -- 也可以直接在字符串的前面加"#"也能获取字符串长度