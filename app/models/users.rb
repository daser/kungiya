class Users < ActiveRecord::Base
  attr_accessible :company, :description, :email, :name, :phone
  attr_accessor :password_confirmation, :updating_password
  validates :email, :presence => true, :uniqueness => true
  validates :name, :presence=> true
  validates :phone, :presence=>true
  validates :company, :presence=>true

  validates :password, :presence =>true,
                    :confirmation =>true,
                    :if => :password_required?

  validates_confirmation_of :password, :message => ' and confirmation do not match', :if => :password_required?
  
  after_validation :prepare_password, :if => :password_required?

def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password == Digest::SHA1.hexdigest(password)
      user
    else
      nil
    end
end
  
   
def prepare_password
    self.password = hash_password(self.password)
end

  
def hash_password(password)
  Digest::SHA1.hexdigest(password)
end


  
def password_required?
  updating_password || !new_record?
end


def send_password_reset
 generate_token (:password_reset_token)
 self.password_reset_sent_at = Time.zone.now
 save!
 UserMailer.password_reset(self).deliver

end

def generate_token(column)
  begin
    
    self[column] = SecureRandom.hex
    
  end while Users.exists?(column => self[column])

  
end
end
