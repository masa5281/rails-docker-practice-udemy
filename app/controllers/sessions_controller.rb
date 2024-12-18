class SessionsController < ApplicationController
  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password]) # userがnilの場合 / authenticateが実際にユーザー名とパスワードがマッチしているかを確認している。
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      render 'index/home'
    end
  end

  def destroy
    session.delete(:user_id) # session情報の削除。sessionオブジェクトのdeleteメソッドで実行。
    redirect_to root_path
  end
end
