module SessionsHelper

	def sign_in(user)
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		# Under the hood, using permanent causes Rails to set the expiration 
		# to 20.years.from_now automatically.
		# cookies[:remember_token] = { value:   remember_token,
    #                     expires: 20.years.from_now.utc }
		user.update_attribute(:remember_token, User.encrypt(remember_token))
		self.current_user = user
		# Here we are defining the current_user at the initial sign_in
		# the purpose is simply to create "current_user" that can be used in various incstructs
		# in views and controllers.
		# without self, Ruby would simply create a local variable called current_user.
		# self.current_user = user is an assignment, which is defined below.
	end

	def signed_in?
		!current_user.nil?
	end

	# The below defines a method current_user= expressly designed to 
	# handle assignment to current_user
	# self.current_user = ...
	# is automatically converted to
	# current_user=(...) thereby invoking the current_user= method.
	def current_user=(user)
		@current_user = user # sets an instance variable @current_user, effectively storing the user for later use.
	end

	# This next method simply follows the current_user throughout the session
	def current_user
		remember_token = User.encrypt(cookies[:remember_token])
		@current_user ||= User.find_by(remember_token: remember_token)
	end
end
