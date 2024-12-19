require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe 'GET #new' do
    before { get new_user_path } # UsersControllerのnewアクションに擬似的にGETリクエストを送る。/ リクエスト結果がresponse変数に格納される。

    it 'HTTPレスポンスステータスコードが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new # gem 'rails-controller-testing'で使用できるマッチャー
    end

    it '新しいuserオブジェクトがビューに渡されること' do
      expect(assigns(:user)).to be_a_new User # be_a_new：ユーザークラスの新しいオブジェクトがセットされているかをテスト。
    end
  end

  describe 'POST #create' do
    let(:referer){ "http://localhost" }
    let(:headers){ { 'HTTP_REFERER' => referer } }

    context '正しいユーザー情報が渡ってきた場合' do
      let(:params) do
        { user: {
            name: 'user',
            password: 'password',
            password_confirmation: 'password',
          }
        }
      end

      it 'ユーザーが一人増えていること' do
        expect { post users_path, params: params }.to change(User, :count).by(1) # Userモデルのカウントの結果がpost前と後で一つ増えているかをテスト。 / このマッチャー（change）を使用する場合はexpectにはテスト対象の処理をブロックで渡す必要がある。
      end

      it 'マイページにリダイレクトされること' do
        expect(post users_path, params: params).to redirect_to(mypage_path)
      end
    end

    context 'パラメーターに正しいユーザー名、確認パスワードが含まれていない場合' do
      before do
        post(users_path, params: {
          user: {
            name: 'ユーザー1',
            password: 'password',
            password_confirmation: 'invalid_password'
          }
        }, headers: headers)      
      end

      it 'リファラ-にリダイレクトされること' do
        expect(response).to redirect_to(referer)
      end

      it 'ユーザー名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end

      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード（確認）とパスワードの入力が一致しません'
      end
    end
  end
end
