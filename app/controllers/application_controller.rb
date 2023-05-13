class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    @current_user ||= User.find_by(email: 'guest@example.com') if Rails.env.development?
    # ゲストユーザーが存在しない場合は、デフォルトでid=1のユーザーをゲストユーザーとして扱う
    @current_user ||= User.find(1) if Rails.env.development?
  end

  def logged_in?
    !!current_user
  end

  def redirect_to_signin
    unless logged_in? || guest_user?
      redirect_to signin_path
    end
  end

  def guest_user?
    current_user.email == 'guest@example.com'
  end
end
