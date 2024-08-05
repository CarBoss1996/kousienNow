class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :code, numericality: { only_integer: true, message: 'は半角数字で入力してください' }

  def self.create_and_send_line_notification(user, post, message)
    # 通知をデータベースに保存
    notification = self.create(user: user, post: post)

    # LINEへの通知を送信
    send_line_notification(message, user.line_user_id)

    notification
  end

  private

  def self.send_line_notification(message, line_user_id)
    # LINE bot APIのクライアントを初期化
    client = Line::Bot::Client.new do |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    end

    # メッセージを作成
    message = {
      type: 'text',
      text: message
    }

    # メッセージを送信
    response = client.push_message(line_user_id, message)

    # エラーハンドリング
    unless Net::HTTPSuccess === response
      Rails.logger.error("Error sending LINE message: #{response.message}")
    end
  end
end
