class SessionsController < ApplicationController

	def new
		
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			# Sign the user in and redirect to user's show page.
			sign_in user # defined in Sessions Helper file - setting remember_token
			redirect_to user
		else
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy
		
	end
end
