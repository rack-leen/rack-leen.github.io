--
--------------------------------------------------------------------------------
--         File:  lib1.lua
--
--        Usage:  ./lib1.lua
--
--  Description:  自定义的lua库文件
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

-- 结果是根号下的x的平方加上y的平方
function norm(x , y)
  return (x^2+y^2)^0.5
end

function twice(x)
  return 2*x
end
