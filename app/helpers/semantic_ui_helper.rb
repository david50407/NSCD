module SemanticUiHelper
	include ActionView::Helpers::FormHelper
	def semantic_form_for(record, options = {}, &block)
		options[:html] ||= {}
		options[:html][:class] ||= ""
		options[:html][:class] << " ui form"
		options[:html][:class].strip!
		form_for(record, options, &block)
	end
end
