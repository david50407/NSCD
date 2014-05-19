class CreateIssueComments < ActiveRecord::Migration
  def change
    create_table :issue_comments do |t|
      t.integer :issue_id
      t.integer :author_id # User
      t.string :content

      t.timestamps
    end
  end
end
