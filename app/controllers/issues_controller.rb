class IssuesController < ApplicationController
  def index
		@status = params[:status] == 'closed' ? :is_close : :is_open
		@labels = Issue::Label.all
		@issues = Issue.where(status: Issue.statuses[@status]).page params[:page]
  end

	def show
		@issue = Issue.find params[:id]
	end

	def new
		@issue = Issue.new do |i|
			i.creator = current_user
		end
	end

	def create
		issue = Issue.create do |i|
			i.creator = current_user
			i.title = post_params[:title]
		end
		issue.comments << Issue::Comment.create do |c|
			c.author = current_user
			c.content = post_params[:comment][:content]
		end
		issue.labels << post_params[:labels].map do |id|
			Issue::Label.find id unless id.empty?
		end - [nil]
		redirect_to issue
	end

	def close
		@issue = Issue.find params[:id]
		if @issue.is_open?
			@issue.is_close!
			@issue.comments << Issue::Comment.create do |c|
				c.author = current_user
				c.is_close!
			end
		end
		redirect_to @issue
	end

	def open
		@issue = Issue.find params[:id]
		if @issue.is_close?
			@issue.is_open!
			@issue.comments << Issue::Comment.create do |c|
				c.author = current_user
				c.is_open!
			end
		end
		redirect_to @issue
	end

	def post_params
		params.require(:issue).permit(:title, :comment => [:content], :labels => [])
	end
end
