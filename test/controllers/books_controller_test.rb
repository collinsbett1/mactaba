require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @user = users(:one)
    post login_path, params: { email: @user.email, password: 'password123' }
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should borrow available book" do
    assert_difference('Borrowing.count') do
      post borrow_book_url(@book)
    end
    assert_redirected_to book_url(@book)
  end

  test "should not borrow unavailable book" do
    # First borrow
    post borrow_book_url(@book)
    # Try to borrow again
    post borrow_book_url(@book)
    assert_redirected_to book_url(@book)
    assert_equal 'Book is not available.', flash[:alert]
  end
end 