class User < ApplicationRecord
  has_secure_password

  has_many :projects

  validates :username, presence: true
  #validates :username, uniqueness: true
  #validates :email, presence: true ~> can't access with Oamniauth
  #validates :password, confirmation: true

  def self.sign_in_from_omniauth(auth)
		find_by(provider: auth[:provider], uid: auth[:uid], username: auth[:info][:name]) || create_user_from_omniauth(auth)
	end

  def self.create_user_from_omniauth(auth)
		create(
		  provider: auth[:provider],
			uid: auth[:uid],
      username: auth[:info][:name]
		)
	end

end
