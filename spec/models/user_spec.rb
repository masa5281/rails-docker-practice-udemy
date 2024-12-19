# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  birthday        :date
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#age' do # テストの対象（#メソッド名）
    before do # テスト実行前に必要な準備をする
      allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2018/04/01')) # Time.zoneのオブジェクトのnowメソッドが呼ばれた場合、parseで記述の日付が呼び出されるようにする。
    end
    context '20年前の生年月日の場合' do # どのような条件で行うテストか（20年前の生年月日が設定されていた場合）
      let(:user) { User.new(birthday: Time.zone.now - 20.years) }

      it '年齢が20歳であること' do # 最終的にどういう状態であることが正しいのかをテスト / テスト対象となるメソッドの呼び出し等を記載する。
        expect(user.age).to eq 20 # letブロックの中で生成した「user」が参照される。
      end
    end

    context '10年前に生まれた場合でちょうど誕生日の場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/01')) }

      it '年齢が10歳であること' do
        expect(user.age).to eq 10
      end
    end

    context '10年前に生まれた場合で誕生日が来ていない場合' do
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/02')) }

      it '年齢が9歳であること' do
        expect(user.age).to eq 9
      end
    end
  end
end
