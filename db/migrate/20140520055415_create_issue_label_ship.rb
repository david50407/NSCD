class CreateIssueLabelShip < ActiveRecord::Migration
  def change
    create_table :issue_label_ships do |t|
			t.integer :issue_id
			t.integer :label_id
			t.timestamp
    end
		remove_column :issue_labels, :issue_id, :integer
  end
end
