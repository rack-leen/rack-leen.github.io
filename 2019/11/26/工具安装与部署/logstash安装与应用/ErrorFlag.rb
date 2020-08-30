class ErrorFlag
	# 初始化实例变量
	def initialize(index , type , preValue , realValue)
		@index 		= index  	# 字段索引位置
		@type 		= type 		# 所校验类型
		@preValue 	= preValue 	# 校验正确值
		@realValue 	= realValue 	# 所校验的值
	end
	
	def createErrorFlag()
		return @index.to_s+"_"+@type.to_s+"_"+@preValue.to_s+"_"+@realValue.to_s
	end
end


