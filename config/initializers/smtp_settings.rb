ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true,
  :user_name => "daserlinux@gmail.com",
  :password => "kinky1289",
  :openssl_verify_mode  => 'none' # Only use this option for a self-signed and/or wildcard certificate

}
