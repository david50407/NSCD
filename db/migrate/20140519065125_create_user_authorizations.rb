class CreateUserAuthorizations < ActiveRecord::Migration
  def change
    create_table :user_authorizations do |t|
      t.string :provider
      t.integer :user_id
      t.string :uid

      t.timestamps
    end
  end
end
