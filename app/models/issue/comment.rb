class Issue::Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :author, class_name: 'User',
                      foreign_key: 'author_id'
end
