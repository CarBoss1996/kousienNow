require 'net/http'
require 'uri'
require 'json'

class NotificationsController < ApplicationController
  protect_from_forgery except: :callback
  before_action :authenticate_user!, only: [:link_line_account]

  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      return head :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        handle_message_event(event)
      end
    end

    head :ok
  end

  def link_line_account
    @user = User.find(current_user.id)

    if request.get?
      @one_time_code = OneTimeCode.find_by(code: params[:unique_code].to_i)
      @unique_code = params[:unique_code]
    elsif request.post?
      unless params[:user]
        flash[:alert] = 'フォームを正しく送信してください。'
        redirect_to link_line_account_notifications_path
        return
      end

      @one_time_code = OneTimeCode.find_by(code: params[:user][:unique_code].to_i)

      if @one_time_code.nil?
        flash.now['danger'] = 'ワンタイムコードが見つかりません。'
        render 'notifications/link_line_account', status: :unprocessable_entity
        return
      end

      if @one_time_code.code == params[:user][:unique_code].to_i && @one_time_code.expires_at && @one_time_code.expires_at > Time.now
        @user.line_user_id = params[:line_user_id]
        @user.save
        redirect_to profile_path, success: 'LINEアカウントが正常にリンクされました。'
      elsif @one_time_code.expires_at.nil? || @one_time_code.expires_at <= Time.now
        flash.now['danger'] = 'ワンタイムコードの有効期限が切れています。'
        render 'notifications/link_line_account', status: :unprocessable_entity
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:unique_code)
  end

  def handle_message_event(event)
    received_text = event['message']['text']
    line_user_id = event['source']['userId']

    case received_text
    when '通知設定'
      user = User.find_by(line_user_id: line_user_id)

      if user
        message = {
          type: 'text',
          text: "通知設定は完了しています。"
        }
      else
        user = User.find_by(line_user_id: nil)
        if user
          unique_code = generate_unique_code(user.id)

          redirect_url = "https://kousiennow.onrender.com/notifications/link_line_account?line_user_id=#{line_user_id}&unique_code=#{unique_code}"

          messages = [
            {
              type: 'text',
              text: "あなたの一意の識別コードは #{unique_code} です。アプリケーションでこのコードを入力してください。このコードの有効期限は１０分です。"
            },
            {
              type: 'text',
              text: "認証を完了するには、次のリンクをクリックしてください：#{redirect_url}"
            }
          ]
        else
          message = {
            type: 'text',
            text: "通知設定をしたい場合は、「通知設定」とメッセージを送ってください。"
          }
        end
      end

      client.reply_message(event['replyToken'], messages || message)
    end
  end

  def generate_unique_code(user_id)
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
