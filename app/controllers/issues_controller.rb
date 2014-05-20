class IssuesController < ApplicationController
  def index
		@status = (params[:status] || :opened).to_sym
		@status = :opened unless [:closed, :opened].include? @status
		@labels = Issue::Label.all
		@issues = Issue.where(status: Issue.statuses[@status]).page params[:page]
  end

	def show
		@issue = Issue.find params[:id]
	end
end
