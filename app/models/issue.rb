class Issue < ActiveRecord::Base
  has_one :creator, class_name: 'User',
                    foreign_key: 'creator_id'
  has_many :labels, class_name: 'IssueLabel'
  has_many :comments, class_name: 'IssueComment'
	enum status: [ :opened, :closed ]
end
