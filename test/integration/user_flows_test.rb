require "test_helper"

class UserFlowsTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @book = books(:one)
  end

  test "user can sign up, login, borrow and return book" do
    # Sign up
    post signup_path, params: { user: { email: 'test@example.com', password: 'password123' } }
    assert_redirected_to root_path

    # Login
    post login_path, params: { email: 'test@example.com', password: 'password123' }
    assert_redirected_to root_path

    # Borrow book
    post borrow_book_path(@book)
    assert_redirected_to book_path(@book)

    # Return book
    borrowing = Borrowing.last
    patch return_borrowing_path(borrowing)
    assert_redirected_to borrowings_path
  end
end 