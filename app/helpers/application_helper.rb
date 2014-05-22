module ApplicationHelper
	include ::SemanticUiHelper

	def actived?(cond)
		cond ? ' active' : ''
	end
end
