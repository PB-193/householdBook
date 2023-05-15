class CommentsController < ApplicationController
  
  def new
    @book = Book.find(params[:book_id])
    @comment = Comment.new
  end
  
  def create
    book = Book.find(params[:book_id]) 
    comment = current_user.comments.new(comment_params)
    comment.book_id = book.id
    if comment.save
      redirect_to book_path(book), notice: 'コメントを投稿しました。'
    else
      flash.now[:alert] = 'コメントの投稿に失敗しました。'
      render 'books/index'
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    book = comment.book
    comment.destroy
    redirect_to book_path(book), notice: 'コメントを削除しました。'
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end

