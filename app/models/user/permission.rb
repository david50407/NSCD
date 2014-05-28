class User::Permission < ActiveRecord::Base
	belongs_to :user
end
