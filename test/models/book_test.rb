require "test_helper"

class BookTest < ActiveSupport::TestCase
  test "should not save book without title" do
    book = Book.new(author: "John Doe", isbn: "1234567890")
    assert_not book.save
  end
  
  test "should not save book with duplicate isbn" do
    Book.create!(title: "Book 1", author: "John Doe", isbn: "1234567890")
    book = Book.new(title: "Book 2", author: "Jane Doe", isbn: "1234567890")
    assert_not book.save
  end
  
  test "should be available when not borrowed" do
    book = Book.create!(title: "Book 1", author: "John Doe", isbn: "1234567890")
    assert book.available?
  end
end 