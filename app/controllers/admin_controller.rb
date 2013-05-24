require 'securerandom'
class AdminController < ApplicationController
  def home
  	@users = Users.find(:all, :conditions=>{:flag =>0})
  end

  def approve
  	    userid = [params[:id]]
  	    gen = generate_random_token
  	    #id = @userid
  	    @user = Users.find(params[:id])
        @user.activation_token = gen
  	    @user.update_attribute("activation_token", gen)
  	    @user.update_attribute("flag", 1)
  	    UserMailer.activation_email(@user).deliver

  	    redirect_to :action=>"home" 

  	    #@user.update_attributes(:activation_token => gen, :active => "1")
  end

  # Random code, used for salt and temporary tokens.
  def generate_random_token
    SecureRandom.hex(15)
  end
end
