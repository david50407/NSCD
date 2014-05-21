class Issues::CommentsController < ApplicationController
  authorize_resource :class => 'Issue::Comment', :through => :issue

	def create
		issue = Issue.find params[:issue_id]
		issue.comments << @comment = Issue::Comment.create do |c|
			c.author = current_user
			c.content = post_params[:content]
		end
		redirect_to issue
	end

	def post_params
		params.require(:issue_comment).permit(:content)
	end
end
