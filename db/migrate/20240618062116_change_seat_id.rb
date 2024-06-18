class ChangeSeatId < ActiveRecord::Migration[7.1]
  def up
    # 外部キー制約を削除
    remove_foreign_key :locations, :seats

    # カラムの型を変更
    change_column :locations, :seat_id, :string

    # 新しい外部キー制約を追加
    add_foreign_key :locations, :seats, column: :seat_id, primary_key: "seat_name"
  end

  def down
    # 外部キー制約を削除
    remove_foreign_key :locations, :seats, column: :seat_id

    # カラムの型を元に戻す
    change_column :locations, :seat_id, :bigint

    # 元の外部キー制約を追加
    add_foreign_key :locations, :seats
  end
end