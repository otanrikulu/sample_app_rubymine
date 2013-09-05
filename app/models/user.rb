class User < ActiveRecord::Base
	# before_save { self.email = email.downcase }
	# has_secure_password

	# An alternative implementation of the above 2 lines
	has_secure_password
  	before_save { email.downcase! }

  	validates :password, length: { minimum: 6 }
	# validates :name, presence: true  is the same as 
	# validates(:name, presence: true)
	validates :name, presence: true, length: { maximum: 50 }
	# VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# A more complex REGEX that checks for consecutive dots.
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, 
						format: { with: VALID_EMAIL_REGEX },
						uniqueness: { case_sensitive: false }
end
