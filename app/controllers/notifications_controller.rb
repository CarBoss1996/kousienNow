require 'net/http'
require 'uri'
require 'json'

class NotificationsController < ApplicationController
  protect_from_forgery except: :callback

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Follow
        handle_follow_event(event)
      end
    end

    head :ok
  end

  def link_line_account
    @user = User.find(current_user.id)

    unless params[:user]
      flash[:alert] = 'フォームを正しく送信してください。'
      redirect_to notifications_path
      return
    end

    @one_time_code = OneTimeCode.find_by(code: params[:user][:unique_code], user_id: @user.id)

    Rails.logger.debug "OneTimeCode: #{@one_time_code.inspect}"

    if @one_time_code && @one_time_code.expires_at > Time.now
      link_token = get_link_token(@user.line_user_id)
      Rails.logger.debug "Link token: #{link_token}"

      send_link_message(@user.line_user_id, link_token)
      redirect_to profile_path, success: 'LINEアカウントが正常にリンクされました。'
    else
      flash.now['danger'] = '無効な一意の識別コードです。'
      render 'notifications/index', status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:unique_code)
  end

  def get_link_token(user_id)
    uri = URI.parse("https://api.line.me/v2/bot/user/#{user_id}/linkToken")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{ENV['LINE_CHANNEL_TOKEN']}"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    JSON.parse(response.body)["linkToken"]
  end

  def send_link_message(user_id, link_token)
    uri = URI.parse("https://api.line.me/v2/bot/message/push")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Authorization"] = "Bearer #{ENV['LINE_CHANNEL_TOKEN']}"
    request.body = JSON.dump({
      "to" => user_id,
      "messages" => [
        {
          "type" => "template",
          "altText" => "Account Link",
          "template" => {
            "type" => "buttons",
            "text" => "Account Link",
            "actions" => [
              {
                "type" => "uri",
                "label" => "Account Link",
                "uri" => "#{Rails.env.production? ? 'https://kousiennow.onrender.com' : 'http://localhost:3000'}/notifications/index?linkToken=#{link_token}"
              }
            ]
          }
        }
      ]
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
  end

  def handle_follow_event(event)
    line_user_id = event['source']['userId']
    unique_code = generate_unique_code(line_user_id)

    message = {
      type: 'text',
      text: "あなたの一意の識別コードは #{unique_code} です。アプリケーションでこのコードを入力してください。"
    }

    client.reply_message(event['replyToken'], message)
  end

  def generate_unique_code(user)
    # 一意の識別コードを生成するロジック...
    # 1000から9999の間のランダムな整数を生成します：
    code = rand(1000..9999)

    # 有効期限を設定します。この例では、コードの有効期限を10分後に設定します：
    expires_at = 10.minutes.from_now

    # 一意のコードとその有効期限をデータベースに保存します：
    # 例: 10分後に有効期限が切れるOneTimeCodeを作成する場合
    OneTimeCode.create(user_id: user_id, code: code, expires_at: Time.current + 10.minutes)

    code
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end
