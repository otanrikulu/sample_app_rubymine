class User < ActiveRecord::Base
	
	# validates :name, presence: true  is the same as 
	# validates(:name, presence: true)

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end