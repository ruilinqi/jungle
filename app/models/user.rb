class User < ApplicationRecord

  has_secure_password

  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, presence: true,  uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    @email = User.all.map{|user| user.email}
    @user = User.find_by_email(email.strip.downcase)
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end

end
