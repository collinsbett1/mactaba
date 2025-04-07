class User < ApplicationRecord
  has_secure_password
  
  has_many :borrowings
  has_many :books, through: :borrowings
  
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
