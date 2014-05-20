class Issue::Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: 'User',
                      foreign_key: 'author_id'
	enum status: [ :is_comment, :is_close, :is_open ]

	before_save :default_values
	def default_values
		self.content ||= ""
		self.status ||= self.class.statuses[:is_comment]
	end
end
