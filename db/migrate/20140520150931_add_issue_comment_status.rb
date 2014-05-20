class AddIssueCommentStatus < ActiveRecord::Migration
  def change
		change_table :issue_comments do |t|
			t.integer :status, default: 0
		end
  end
end
