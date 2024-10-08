# frozen_string_literal: true

class Comment < ApplicationRecord
  validates :body, presence: true, length: { maximum: 255 }
  belongs_to :user
  belongs_to :post
  after_create :send_line_notification

  private

  def send_line_notification
    # postの所有者のline_user_idを取得
    line_user_id = post.user.line_user_id

    # デバッグ用出力
    puts "line_user_id: #{line_user_id.inspect}"

    # line_user_idが存在する場合のみ、LINE通知を送信
    return unless line_user_id.present? && line_user_id.is_a?(String)

    post_url = "https://kousiennow.onrender.com/posts/#{post.id}"
    message = "#{post.user.user_name}さん、あなたの投稿に#{user.user_name}さんからコメントがあります。\n\"#{body}\" \n#{post_url}"
    Notification.create_and_send_line_notification(line_user_id, message)
  end
end
