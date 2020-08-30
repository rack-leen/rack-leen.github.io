require 'rubygems'
require 'json'
require 'pp'

require_relative 'ErrorFlag'
#class ErrorFlag
#	# 初始化实例变量
#	def initialize(index , type , preValue , realValue)
#		@index 		= index  	# 字段索引位置
#		@type 		= type 		# 所校验类型
#		@preValue 	= preValue 	# 校验正确值
#		@realValue 	= realValue 	# 所校验的值
#	end
#	
#	def createErrorFlag()
#		return @index.to_s+"_"+@type.to_s+"_"+@preValue.to_s+"_"+@realValue.to_s
#	end
#end


def register(params)
    @message = params["message"]
end

def filter(event)
	# 获取全集，存入json数组
	json = File.read('get_logNorm_prefix.json')
	obj = JSON.parse(json)	
	topics_json = obj['data']
	# 从文件中获取需要排除的集合 不需要过滤的集合(里面是topic名)
	nofilter = Array.new
	file = File.open('nofilter.txt','r')
	while line = file.gets
		nofilter.push(line)
	end
	
	
	# 得到需要校验的有公共字段的数据
	for i in nofilter
		nofilterName = i.strip
		# 判断是否有不需要过滤的topic , 如果为true删除
		if topics_json.key?(nofilterName)
			topics_json.delete(nofilterName)
		end
	end
	
	length = 14 # 前缀名的长度
	
	path = event.get('path')
	filename = path.split('/')[path.split('/').length-1]
	name = filename.split('.')[0]
	if name.length >= length
		# 获取kafka topic名
		prefix_name = filename[0,length]
	else
		return [] # topic名不合法
	end
	
	# 判断获取的topic是否在hash数组中，如果在，则获取得到的分隔符数量,如果不存在，则不再执行
	
	field_num = 0
	if topics_json.key?(prefix_name)
		field_num = topics_json[prefix_name]+1
	else
		return []
	end
		
	# 获取当前事件的长度
	infos = ""
	message = event.get('message')
	if message != nil or message != ""
		infos = message.split('|^|')
	else
		return []
	end
	# 增加错误字段
	feildIndex 	= [2 , 13 , 14 , 20 , 21]  	# 校验字段索引
	inet_type_num 	= ['01','02','03','04'] # 可选网络类型
	inet_standard 	= ['01','02','03','04','05']
	error_log_type 	= ['L','M']	 	# 所校验的类型
	

	log_phone = infos[feildIndex[0]]
	if log_phone == nil
		log_phone = ""
	end
	log_inet_type = infos[feildIndex[1]]
	if log_inet_type == nil
		log_inet_type = ""
	end
	log_inet_standard = infos[feildIndex[2]]
	if log_inet_standard == nil
		log_inet_standard = ""
	end
	log_city_code = infos[feildIndex[3]]
	if log_city_code == nil
		log_city_code  = ""
	end
	log_city_num = infos[feildIndex[4]]
	if log_city_num == nil
		log_city_num = ""
	end


	logPhoneSize 	= 11 			# 所需手机号长度
	logCityCodeSize = 6  			# 所需城市代码长度
	logCityNumSize 	= 3 			# 所需城市区号长度

	phoneFlag 		= ErrorFlag.new(feildIndex[0],error_log_type[0],logPhoneSize,log_phone.size).createErrorFlag()
	inetTypeFlag 		= ErrorFlag.new(feildIndex[1],error_log_type[1],inet_type_num,log_inet_type).createErrorFlag()
	inetStandardFlag 	= ErrorFlag.new(feildIndex[2],error_log_type[1],inet_standard,log_inet_standard).createErrorFlag()
	cityCodeFlag 		= ErrorFlag.new(feildIndex[3],error_log_type[0],logCityCodeSize,log_city_code.size).createErrorFlag()
	cityNumFlag 		= ErrorFlag.new(feildIndex[4],error_log_type[0],logCityNumSize,log_city_num.size).createErrorFlag()
	# 如果当前事件长度等于当前输入源topic应该有的长度，则判定这个事件为合法事件，并开始校验
	if infos.length == field_num
		log_error = Array.new

		log_phone_flag = (log_phone.size != logPhoneSize and log_phone.size != 0)
		log_inet_type_flag = (log_inet_type.size !=0 and !(inet_type_num.include?log_inet_type))
		log_inet_standard_flag = (log_inet_standard.size !=0 and !(inet_standard.include?log_inet_standard))
		log_city_code_flag = (log_city_code.size != 0 and log_city_code.size != logCityCodeSize)
		log_city_num_flag = (log_city_num.size != 0 and log_city_num.size != logCityNumSize) 
		# 如果下列判断的公共字段其中一个不正确，则表示这个日志为非法日志
		if log_phone_flag or log_inet_type_flag or log_inet_standard_flag or log_city_code_flag or log_city_num_flag
			if log_phone_flag then log_error.push(phoneFlag) end
			if log_inet_type_flag then log_error.push(inetTypeFlag) end
			if log_inet_standard_flag then log_error.push(inetStandardFlag) end
			if log_city_code_flag then log_error.push(cityCodeFlag) end
			if log_city_num_flag then log_error.push(cityNumFlag) end
			message = message+"|^|"+log_error.join(",")
			event.set('fileName' , filename)
			event.set('message', message)	
			return [event]
		else # 所有的校验条件都通过了，表示这个日志为正确日志
			return []
		end
	else
		return []
	end
end
