class BooksController < ApplicationController
  before_action :redirect_to_signin

  def index
    @books = Book.where(user_id: session[:user_id])
    # allだったのを、ログインしているユーザーのidで検索するようにしています。
    @books = @books.where(year: params.require(:year)) if params[:year].present?
    @books = @books.where(month: params.require(:month)) if params[:month].present?
    @books = @books.where(inout: params.require(:inout)) if params[:inout].present?
  end

  def show
    @book = Book.where(user_id: session[:user_id]).find(params[:id])
  end

  def new
    @book = Book.new
    # @book.year = 2019
    # で直接フォームに入力している状態にできる
  end

  def create
    @book = current_user.books.build(book_params)
    @book = Book.new(book_params)
    @book.user_id = session[:user_id]
    # 現在ログインしているユーザーのid {session[:user_id]} を@book.user_idに代入することで、誰が家計簿を登録したかを記録することができます。
    # もし@book.user_id = session[:user_id]がない場合、user_idカラムには何も値が代入されず、
    # ログインしているユーザーの情報が家計簿に保存されないため、誰が登録したのかが分からなくなってしまいます。
    if @book.save
      flash[:notice] = "家計簿に「#{@book.year}年#{@book.month}月#{@book.category}」を登録しました"
      redirect_to books_path
    else
      render :new
    end
  end

  def edit
    @book = Book.where(user_id: session[:user_id]).find(params[:id])
  end

  def update
    @book = Book.where(user_id: session[:user_id]).find(params[:id])
    if @book.update(book_params)
      flash[:notice] ="家計簿の「#{@book.year}年#{@book.month}月#{@book.category}」を更新しました"
      redirect_to book_path
    else
      render :edit
    end
  end

  def destroy
    @book = Book.where(user_id: session[:user_id]).find(params[:id])
    @book.destroy
    flash[:notice] = "削除しました"
    redirect_to books_path
  end

  private
  
  def book_params
    params.require(:book).permit(:year,:month, :inout, :amount, :category)
  end
  

end
