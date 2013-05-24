class UserMailer < ActionMailer::Base
  default :from => "Kungiya.com"

  def activation_email(user)
  	@user = user
  	@activation_url = "http://0.0.0.0:3000/confirm/#{user.activation_token}/activation"
  	@loginurl = 'kungiya.com/login'
  	email_with_name = "#{@user.name} <#{@user.email}>"
  	mail(:to=>email_with_name,:subject=>"Confirm your registration at kungiya.com") do |format|
      format.html { render 'activation_email' }
    end

    #mail(:to=>email_with_name,:subject=>"Confirm your registration at kungiya.com") do |format|
    #  format.html { render 'activation_email' }
    #end


  end

  def successful_registration(user)
    @user = user
    @company = user.company
    @admin = user.name
    mail(:to => user.email,:subject=>"Registration Successful")
  end


  def new_registration(user)
    @user = user
    @company = user.company
    mail(:to => user.email,:subject=>"Thank You")
  end


  def password_reset(user)
    @user = user
    @company = user.company
    @reset_url = "http://0.0.0.0:3000/passwordedit/#{user.password_reset_token}"
    mail(:to => user.email,:subject=>"Your Password Reset Request")
  end

end
