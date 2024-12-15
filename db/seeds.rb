# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Railsの現在の動作環境を判定 / development環境でのみデータが追加されるよう条件分岐
if Rails.env == 'development'
  (1..50).each do |i|
    Board.create(author_name: "ユーザー#{i}", title: "タイトル#{i}", body: "本文#{i}")
  end

  # 配列の中でハッシュ形式でまとめて指定
  Tag.create([
    { name: 'Ruby' },
    { name: 'Ruby on Rails4' },
    { name: 'Ruby on Rails5' },
    { name: 'Python2' },
    { name: 'Python3' },
    { name: 'Django2' }
  ])
end