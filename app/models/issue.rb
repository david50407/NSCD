class Issue < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
	has_many :label_ships
  has_many :labels, :through => :label_ships
  has_many :comments
	enum status: [ :opened, :closed ]
end
