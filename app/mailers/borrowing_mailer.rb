class BorrowingMailer < ApplicationMailer
  def due_date_reminder
    @borrowing = params[:borrowing]
    @user = @borrowing.user
    @book = @borrowing.book

    mail(
      to: @user.email,
      subject: "Reminder: '#{@book.title}' is due soon"
    )
  end
end 