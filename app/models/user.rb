class User < ApplicationRecord
  has_secure_password

  has_many :projects

  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :password, confirmation: true

end
