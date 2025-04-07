module Admin
  class BooksController < ApplicationController
    before_action :require_admin
    before_action :set_book, only: [:edit, :update, :destroy]

    def new
      @book = Book.new
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to @book, notice: 'Book was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @book.update(book_params)
        redirect_to @book, notice: 'Book was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy
      redirect_to books_url, notice: 'Book was successfully deleted.'
    end

    private

    def require_admin
      unless current_user&.admin?
        redirect_to root_path, alert: 'Unauthorized access'
      end
    end

    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :isbn)
    end
  end
end 