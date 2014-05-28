class User < ActiveRecord::Base
  extend OmniauthCallbacks
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

	has_many :permissions
	has_many :issues
	has_many :issue_comments

	attr_reader :fullname

	validates :username, uniqueness: { case_sensitive: false }

	def self.find_first_by_auth_conditions(warden_conditions)
		conditions = warden_conditions.dup
		if username = conditions.delete(:username)
			self.where(conditions)
			    .where(["lower(username) = :value OR lower(email) = :value", value: username.downcase])
			    .first
		else
			self.where(conditions)
			    .first
		end
	end

	def fullname
		lastname.to_s + firstname.to_s
	end
end
