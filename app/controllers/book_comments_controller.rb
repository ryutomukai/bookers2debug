class BookCommentsController < ApplicationController

  before_action :ensure_current_user, {only: [:destroy]}
  def ensure_current_user
    @comment = Comment.find(params[:id])
    if current_user.id != @comment.user_id
      flash[:notice]="権限がありません"
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
    redirect_back(fallback_location: root_path)
  end


  def destroy
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.find_by(book_comment_params)
    @comment.destroy
    redirect_back(fallback_location: root_path)
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end


end
