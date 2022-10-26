class User < ApplicationRecord
  has_secure_password
  

  validates :name, presence: true
  validates :email, presence: true
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, :length => { :minimum => 4 }
  validates :email, :uniqueness => { :case_sensitive => false }

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.strip.downcase)

    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
