class Issue < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
	has_many :label_ships
  has_many :labels, :through => :label_ships
  has_many :comments
	enum status: [ :is_open, :is_close ]

	before_save :default_values
	def default_values
		self.status ||= self.class.statuses[:is_open]
	end
end
