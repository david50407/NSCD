class IssuesController < ApplicationController
  def index
		@labels = Issue::Label.all
    @issues = Issue.page params[:page]
  end

	def show
		@issue = Issue.find params[:id]
	end
end
