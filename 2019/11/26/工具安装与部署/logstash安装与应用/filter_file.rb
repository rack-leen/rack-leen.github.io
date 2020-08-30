require 'rubygems'
require 'json'
require 'pp'


def register(params)
    @message = params["message"]
end

def filter(event)
	# 获取message中的数据
	message = event.get("message")

	# 开始对message信息过滤

	path = event.get('path')
	filename = path.split('/')[path.split('/').length-1]
	name = filename.split('.')[0]

	if message != nil
		event.set("filename" , name)
		event.set("message" , message)
		return [event]
	else
		return []
end
