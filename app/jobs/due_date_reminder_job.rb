class DueDateReminderJob < ApplicationJob
  queue_as :default

  def perform
    Borrowing.where(returned_at: nil)
            .where(due_date: Date.tomorrow)
            .find_each do |borrowing|
      BorrowingMailer.with(borrowing: borrowing).due_date_reminder.deliver_later
    end
  end
end 