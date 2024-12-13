class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :board, null: false, foreign_key: true # 特定のboardと関連付けるためのboar_idカラムが生成される / 外部キー制約（foreign_key: true） →　boardテーブルに存在しないIDはboard_idに保存できない。
      t.string :name, null: false
      t.text :comment, null: false

      t.timestamps
    end
  end
end
