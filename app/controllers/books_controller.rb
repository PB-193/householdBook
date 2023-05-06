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

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "家計簿に１件データを登録しました"
      redirect_to books_path
    else
      flash.now[:alert] = "登録に失敗しました"
      render :new
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:year,:month, :inout, :amount, :category)
  end

end
