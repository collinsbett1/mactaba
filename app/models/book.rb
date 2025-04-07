class Book < ApplicationRecord
  has_many :borrowings
  has_many :users, through: :borrowings
  
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
  
  scope :search, ->(query) {
    where('title ILIKE :query OR author ILIKE :query OR isbn ILIKE :query',
          query: "%#{query}%")
  }
  
  def available?
    !borrowings.where(returned_at: nil).exists?
  end
  
  def current_borrowing
    borrowings.where(returned_at: nil).first
  end
end 