#! /usr/bin/lua 

function my_string()
    print("用双引号界定打印字符串")
    print("one line\n\"in quotes \",'in quotes'") -- 用普通的双引号界定打印字符串
    print("用单引号界定打印字符串")
    print('a backslash inside quotes : \'\\\'')   -- 用单引号界定打印字符串
    print("用ascii码打印字符串")
    print("正常字符")
    print("alo\n123\"")
    print("ascii码字符")
    print('\97lo\10\04923"') -- a --> \97   \n --> \10   1 --> \049


    print("用双方括号界定打印字符串")
    page = [==[
    --[[
    a=b[c[i]]
    --]]
    ]==]
    page1 = [[
    <html>
    <body>
    <a href="http://www.lua.org">Lua</a>
    </body>
    </html>
    ]]
    print(page)
    print(page1)
end
--[==[
--aa
--]==]


my_string()
