class CreateIssueLabels < ActiveRecord::Migration
  def change
    create_table :issue_labels do |t|
      t.integer :issue_id
      t.integer :color # AARRGGBB
      t.string :name
      t.timestamps
    end
  end
end
