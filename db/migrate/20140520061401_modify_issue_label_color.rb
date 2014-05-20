class ModifyIssueLabelColor < ActiveRecord::Migration
  def change
		remove_column :issue_labels, :color, :integer
		add_column :issue_labels, :color, :string
  end
end
