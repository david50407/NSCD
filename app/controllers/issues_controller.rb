class IssuesController < ApplicationController
	authorize_resource
  def index
		@status = params[:status] == 'closed' ? 'closed' : 'opened'
		status = @status == 'closed' ? :is_close : :is_open
		@sort = params[:sort] || 'newest'
		@sort = 'newest' unless %W(newest oldest newest_update oldest_update).include? @sort
		sort = case @sort.to_s.to_sym
						when :newest
							{:created_at => :desc}
						when :oldest
							{:created_at => :asc}
						when :newest_update
							{:updated_at => :desc}
						when :oldest_update
							{:updated_at => :asc}
						#when :most_comments
						#	{:comments_count => :desc}
						#when :least_comments
						#	{:comments_count => :desc}
						else
							{:created_at => :desc}
						end
		@labels = Issue::Label.all
		@issues = Issue.where(status: Issue.statuses[status]).order(sort).page params[:page]
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
