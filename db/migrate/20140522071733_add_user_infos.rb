class AddUserInfos < ActiveRecord::Migration
  def change
		change_table :users do |t|
			t.string :username, default: ""
			t.string :nickname, default: ""
			t.string :firstname, default: ""
			t.string :lastname, default: ""
			t.string :phone, default: ""

		end
		add_index :users, :username, :unique => true
  end
end
