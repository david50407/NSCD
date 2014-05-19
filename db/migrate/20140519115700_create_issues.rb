class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :status
      t.string :title
      t.integer :creator_id # User

      t.timestamps
    end
  end
end
