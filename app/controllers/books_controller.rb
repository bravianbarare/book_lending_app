class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def borrow
    @book = Book.find(params[:id])
    if @book.borrowings.where(returned_at: nil).exists?
      redirect_to @book, alert: "Book is already borrowed."
    else
      @book.borrowings.create(user: current_user, due_date: 2.weeks.from_now)
      redirect_to @book, notice: "Book borrowed successfully."
    end
  end

  def return
    @book = Book.find(params[:id])
    borrowing = @book.borrowings.where(user: current_user, returned_at: nil).first
    if borrowing
      borrowing.update(returned_at: Time.now)
      redirect_to @book, notice: "Book returned successfully."
    else
      redirect_to @book, alert: "You have not borrowed this book."
    end
  end
end