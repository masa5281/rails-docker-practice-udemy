# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  validates :name,
  presence: true,
  uniqueness: true,
  length: { maximum: 16 },
  format: {
    width: /\A[a-z0-9]+\z/, # 小文字のアルファベットか数字の0〜9のいずれかが1文字以上続く。
    message: 'は小文字英数字で入力してください' # 「不正な値です」というデフォルトのエラーメッセージをより明示的にするために指定
  }
  validates :password, 
  length: { minimun: 8 }
end
