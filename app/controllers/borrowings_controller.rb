class BorrowingsController < ApplicationController
  before_action :require_login
  
  def index
    @borrowings = current_user.borrowings.where(returned_at: nil)
  end
  
  def return
    @borrowing = current_user.borrowings.find(params[:id])
    
    if @borrowing.update(returned_at: Time.current)
      redirect_to borrowings_path, notice: 'Book was successfully returned.'
    else
      redirect_to borrowings_path, alert: 'Could not return book.'
    end
  end
end 