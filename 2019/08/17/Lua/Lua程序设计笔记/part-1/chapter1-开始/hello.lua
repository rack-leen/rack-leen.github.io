--
--------------------------------------------------------------------------------
--         File:  hello.lua
--
--        Usage:  ./hello.lua
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

-- 第一个打印函数
function hello()
  -- 打印字符串
  print(" hello world ! ")
end

-- 第一个阶乘函数
function fact(n)
  -- 如果输入的数是0，则阶乘直接返回1
  if n == 0 then
    return 1 
  else
    return n*fact(n-1)
  end
end

-- 执行第一个函数
hello()

print("enter a number : ")
a = io.read("*number") -- 读取一个数字
print(fact(a))
