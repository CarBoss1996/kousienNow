class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post

  def self.create_and_send_line_notification(user, post, message)
    # 通知をデータベースに保存
    notification = self.create(user: user, post: post)

    # LINEへの通知を送信
    send_line_notification(message)

    notification
  end

  private

  def self.send_line_notification(message)
    # 先ほど示した関数の内容をここにコピー
  end
end
