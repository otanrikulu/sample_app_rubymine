class UsersController < ApplicationController
  
  def show
  	@user = User.find(params[:id])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	# The statement "@user = User.new(params[:user])" is the same thing as the following...
  	# @user = User.new(name: "Foo Bar", email: "foo@invalid", password: "foo", password_confirmation: "bar")
  	# params[:user] is the hash of user attributes. params{} is a hash of user{} hash.
  	# User hash with attributes corresponding to 
  	# the submitted values, where the keys come from the name attributes 
  	# of the input tags of the form.
  	if @user.save
  		# we can omit the user_url in the redirect, 
  		# writing simply "redirect_to @user" to redirect to the user "show" page
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  	# the private user_params takes care of privatizing params[:user]
  	# in the Create action.
    def user_params
    	params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
