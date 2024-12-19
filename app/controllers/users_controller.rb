class UsersController < ApplicationController
  def new
    @user = User.new(flash[:user]) # バリデーションエラーをしても入力したユーザーネームは消えずに残る。
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      flash[:user] = user # session情報のuserというキーに登録したユーザのIDを保存する。 / これを保持しているかでログイン中かを判断する。
      flash[:error_messages] = user.errors.full_messages
      redirect_to request.referer || new_user_path, allow_other_host: true
    end
  end

  def me
  end

  private

  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
