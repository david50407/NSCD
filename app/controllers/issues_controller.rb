class IssuesController < ApplicationController
  def index
    @issues = Issue.page params[:page]
  end
end
