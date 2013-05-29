class HomeController < ApplicationController
  layout :resolve_layout
  before_filter :save_login_state!, :only =>[:login, :index, :get_started, :password_reset]

  def index
  end

  def register
  end

  def login
  	#@user = Users.new
  end

  def logout
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end


  def signin
    if request.post?
      user = Users.authenticate(params[:email], params[:password])
      if user
        if user.active != 0
          session[:user_id] = user.id
          redirect_to "/home"
          #logger.info("This is it " + user)
        else
          flash.now.alert = "This account has not been activated"
          render "login"          
        end
      else
        flash.now.alert = "Invalid email or password"
        render "login"
      end
    else
      render "login"
    end
  end


  def passwordreset
    if request.post?
        user = Users.find_by_email(params[:email])
        if user
        user.send_password_reset 
        redirect_to root_url, :notice => "Email sent with password reset instructions."
        else
          flash[:notice] = "This email " + params[:email] +" does not exist."
         # flash[:notice] = "Please ensure that the username is spelled correctly and try again, or use the domain field instead. 
          #flash[:notice] = "If this problem continues, please contact support."
          flash[:color] = "invalid"          
        end
    end
  end 

  def passresedit
    @user = Users.find_by_password_reset_token(params[:token])
    if @user
      if request.post?

        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]
        if password != password_confirmation
          logger.info("***** password doesn't match confirmation")
          flash[:notice] = "***** password doesn't match confirmation"
          flash[:color] = "invalid"
        elsif @user.password_reset_sent_at < 2.hours.ago
          redirect_to :action=>"password-reset", :alert => "Password reset has expired."
        else
          #@user.update_attributes(params[:user])
          @user.updating_password = true
          @user.password = password
          @user.password_reset_token = nil
          if @user.save
          redirect_to root_url, :notice => "Password has been reset!"
          #redirect_to profile_path(@get_user.username)
          else
            flash[:notice] = 'Your password could not be changed. Please try again'
          end    
        end
      end
  else
    flash[:notice] = "Invalid token"
    redirect_to :action=>"index"
  end
end

  def feedback
      @user = Users.new(params[:user])
      if request.post?
        if @user.save
          UserMailer.new_registration(@user).deliver
          flash[:notice] = "Thanks for the feedback"
          flash[:color] = "valid"
        else
          flash[:notice] = "Form is invalid"
          flash[:color] = "invalid"
        end
      end
    # redirect_to :action=>"index" 
  end

  def activate
    @token = [params[:token]]
    
    ifexist = Users.find_by_activation_token(@token)
    if ifexist
      @user = ifexist
      if request.post?
        password = params[:user][:password]
        password_confirmation = params[:user][:password_confirmation]
        if password != password_confirmation
          flash[:notice] = "***** password doesn't match confirmation"
          flash[:color] = "invalid"
        else
          @user.updating_password = true
          @user.password = password
          @user.active = 1
          @user.activation_token = nil
          if @user.save
            UserMailer.successful_registration(@user).deliver
            redirect_to root_url, :notice => "Account Activated! You can now login"

          #redirect_to profile_path(@get_user.username)
          else
            logger.info('hashed password 2: '+ @user.password)
            flash[:notice] = 'Your password could not be changed. Please try again'
          #@page = "Change Password"
          #@header_image = 'change-password'
          #render(:action => 'password')
          end    
        end
      end
  else
    flash[:notice] = "Invalid token"
    redirect_to :action=>"index"
  end

    

  end



def doactivate
  if request.post?
    @id = [params[:token]]
    @userid = [params[:userid]]
    password = [params[:password]]
    @cpassword = [params[:password_confirmation]]
    @user = Users.find(params[:userid])
    @user.update_attribute("password", password)

  end
end

def team
  
end

def contact
  
end

 
def hash_password(password)
  Digest::SHA1.hexdigest(password)
end


private 
def resolve_layout
  case action_name
  when "login","passwordreset","feedback","activate","signin","team","contact"
    "unauthenticate"
  else
    "application"
  end
end


end
