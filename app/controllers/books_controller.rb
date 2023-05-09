class BooksController < ApplicationController
  before_action :redirect_to_signin

  def index
    @books = Book.where(user_id: session[:user_id])
    # allだったのを、ログインしているユーザーのidで検索するようにしています。
    @books = @books.where(year: params.require(:year)) if params[:year].present?
    @books = @books.where(month: params.require(:month)) if params[:month].present?
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
    book_params[:user_id] = session[:user_id]
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "家計簿に「#{@book.year}年#{@book.month}月#{@book.category}」を登録しました"
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
      flash[:notice] ="家計簿の「#{@book.year}年#{@book.month}月#{@book.category}」を更新しました"
      redirect_to book_path
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    flash[:notice] = "削除しました"
    redirect_to books_path
  end

  private
  
  def book_params
    params.require(:book).permit(:year,:month, :inout, :amount, :category)
  end
  

end
