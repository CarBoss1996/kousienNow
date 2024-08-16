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

    return handle_get_request if request.get?
    return handle_post_request if request.post?
  end

  private

  def user_params
    params.require(:user).permit(:unique_code)
  end

  def handle_get_request
    @one_time_code = OneTimeCode.find_by(code: params[:unique_code].to_i)
    @unique_code = params[:unique_code]
  end

  def handle_post_request
    return redirect_with_alert unless params[:user]

    @one_time_code = OneTimeCode.find_by(code: params[:user][:unique_code].to_i)
    return render_with_danger if @one_time_code.nil?

    handle_one_time_code
  end

  def redirect_with_alert
    flash[:alert] = 'フォームを正しく送信してください。'
    redirect_to link_line_account_notifications_path
  end

  def render_with_danger
    flash.now['danger'] = 'ワンタイムコードが見つかりません。'
    render 'notifications/link_line_account', status: :unprocessable_entity
  end

  def handle_one_time_code
    if @one_time_code.code == params[:user][:unique_code].to_i && @one_time_code.expires_at && @one_time_code.expires_at > Time.now
      link_line_account_or_redirect
    elsif @one_time_code.expires_at.nil? || @one_time_code.expires_at <= Time.now
      flash.now['danger'] = 'ワンタイムコードの有効期限が切れています。'
      render 'notifications/link_line_account', status: :unprocessable_entity
    end
  end

  def link_line_account_or_redirect
    if @user.line_user_id.nil?
      @user.line_user_id = params[:line_user_id]
      if @user.save
        flash[:notice] = 'LINEアカウントが正常にリンクされました。'
        redirect_to profile_path
      else
        flash[:alert] = 'LINEアカウントのリンクに失敗しました。'
        render 'notifications/link_line_account'
      end
    else
      flash[:notice] = 'LINEアカウントは既にリンクされています。'
      redirect_to profile_path
    end
  end

  def handle_message_event(event)
    received_text = event['message']['text']
    line_user_id = event['source']['userId']

    unless received_text == '通知設定'
      message = {
        type: 'text',
        text: "通知設定をしたい場合は、「通知設定」とメッセージを送ってください。"
      }
      return client.reply_message(event['replyToken'], message)
    end

    user = User.find_by(line_user_id: line_user_id)

    if user
      message = {
        type: 'text',
        text: "通知設定は完了しています。"
      }
      return client.reply_message(event['replyToken'], message)
    end

    unique_code = SecureRandom.hex(10)

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
    return client.reply_message(event['replyToken'], messages)
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
