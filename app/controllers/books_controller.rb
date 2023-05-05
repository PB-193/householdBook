class BooksController < ApplicationController
  def index
    @books = Book.all
  end
  
  def show
    @book = Book.find(params[:id])
  end
  
  def new
    @book = Book.new
    # @book.year = 2019 
    # で直接フォームに入力している状態にできる
  end
end
