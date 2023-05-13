class UsersController < ApplicationController
  before_action :redirect_to_signin, only: [:show, :edit, :update]
  
    def self.guest
      find_or_create_by!(email: 'guest@example.com') do |user|
        user.name = 'Guest User'
        user.password = SecureRandom.urlsafe_base64
      end
    end
  
  def show
    @user = User.find(params[:id])
    if session[:user_id] == @user.id
      # プロフィールページにアクセスしているユーザーが、表示しているユーザー自身である場合
      @books = @user.books
    else
      # プロフィールページにアクセスしているユーザーが、表示しているユーザー自身ではない場合
      render 'session/new'
    end
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "会員登録が完了しました"
      redirect_to signin_path
    else
      flash[:alert] ="会員登録に失敗しました"
      render :new
    end
  end
  
  def edit
    @user = User.find(session[:user_id])
  end
  
  def update
    @user = User.find(session[:user_id])
    if @user.update(user_params1)
      if params[:user][:avatar].present?
        @user.create_avatar(params[:user][:avatar])
      end
      flash[:notice] = "会員登録の内容を更新しました"
      redirect_to edit_user_path(@user)
    else
      flash[:alert] = "更新が失敗しました"
      render :edit
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def user_params1
    params.require(:user).permit(:name, :email, :avatar)
  end
  
end

