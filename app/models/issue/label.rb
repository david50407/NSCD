class Issue::Label < ActiveRecord::Base
	has_many :label_ships
	has_many :issues, :through => :label_ships
end
