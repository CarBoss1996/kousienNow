class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 255 }
  belongs_to :user
  belongs_to :post
  after_create :send_line_notification

  private

  def send_line_notification
    # postの所有者のline_user_idを取得
    line_user_id = self.post.user.line_user_id

    # line_user_idが存在する場合のみ、LINE通知を送信
    if line_user_id
      message = "#{self.user.user_name}さんがあなたの投稿にコメントしました：#{self.body}"
      Notification.create_and_send_line_notification(message, line_user_id)
    end
  end
end
