class BooksController < ApplicationController
  before_action :require_login, except: [:index, :show]
  
  def index
    @books = if params[:query].present?
               Book.search(params[:query])
             else
               Book.all
             end
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def borrow
    @book = Book.find(params[:id])
    
    if @book.available?
      borrowing = current_user.borrowings.build(book: @book)
      
      if borrowing.save
        redirect_to @book, notice: 'Book was successfully borrowed.'
      else
        redirect_to @book, alert: 'Could not borrow book.'
      end
    else
      redirect_to @book, alert: 'Book is not available.'
    end
  end
end 