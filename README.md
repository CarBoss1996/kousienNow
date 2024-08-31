<h1>甲子園NOW！</h1>
<h4>サービスURL：<a href="https://kousiennow.onrender.com/">https://kousiennow.onrender.com/</a></h4>
<p>甲子園NOWは、甲子園球場での観戦をより楽しくするためのSNSアプリです。<br>
今の興奮、感動を共有しよう！</p>
<img src="https://github.com/user-attachments/assets/9c69de69-60ce-450c-ac2b-02b01e451986" width="800"/>


<h2>■サービス概要</h2>
<p>甲子園球場の盛り上がりや興奮を文字と画像で投稿でき、コメントやいいね機能もあるので、ユーザー同士の交流ができます。<br>
自分の投稿にコメントが来たときは、LINE通知がくるように設定できます。<br>
位置情報にアイコンを一緒に登録することができ、今日の観戦位置をユーザー同士で共有することができます。<br>
また、観戦カレンダーでは試合、イベント情報の閲覧と、自身の観戦予定の登録、履歴の閲覧が可能です。</p>
<br>

<h2>■機能一覧</h2>
・ユーザー登録　( gem devise )<br>
・いいね・コメント機能　( turbo )<br>
・位置情報登録機能　（ GeolocationAPI、Javascript ）<br>
・アイコンの表示機能　（　turbo、Javascript　）<br>
・カレンダー機能　（ gem simple_calendar ）<br>
・コメント通知機能　（　line-bot-api　）<br>
・OmniOAuth認証機能　（　Google+ API、LINEログイン　）<br>
<br>

<h2>■このサービスへの思い・作りたい理由</h2>
<p>甲子園球場での観戦中、試合の盛り上がりを近場の方々だけでなくもっと広い範囲で、甲子園球場全体のファンの方々と共有したいと思った経験から、このサービスを思いつきました。<br>
観戦しているときに、隣の席の人との会話が盛り上がったり、SNSで「今ここにいる！」と共有したりする楽しさをアプリで提供したいと思いました。</p>
<br>

<h2>■他のSNSとの差別化</h2>
<p>X : リアルタイムでのシェアに特化していますが、位置情報やアイコンなどは使用できません。</p>
<p>Instagram: 位置情報は表示できますが、文章のみの表示になり、投稿もリアルタイム性に欠けストーリーも1日で消えてしまいます。</p>
<p>上記の欠点を補う新しいSNSサービスとして、甲子園NOWは登場します。<br>
位置情報画面を一覧で表示できるようにして、実際の甲子園の盛り上がりが目視でき、ファン同士のコミュニケーションの場として活躍できるアプリです。</p>
<br>

<h2>■ユーザー層について</h2>
<p>甲子園球場で観戦するファン:<br>
理由: 球場内でのリアルタイムな交流を促進し、甲子園観戦での同じファンとの交流という野球観戦においての楽しみを増やすため。</p>
<p>SNS好きの若年層:<br>
理由: リアルタイムでの位置情報付き投稿や、いいね・コメント機能で、SNS感覚で楽しめるため。<br>
また、ビールやチューハイ、カレーやたこ焼きなどのアイコンを使った投稿機能で、観戦の楽しさを共有できるため。</p>
<p>阪神タイガースファン：<br>
理由：　タイガースファンならわかるはず。</p>
<br>

<h2>■ユーザーの獲得について</h2>
<p>身近な阪神ファンに向けて:
まず初めに使ってみてもらい、フィードバックをいただく。その後、SNSでの告知や口コミに移行する。</p>
<p>SNSでのユーザー獲得:
若年層にリーチするため、TwitterやInstagramで阪神ファンの方に触ってもらう。</p>
<p>口コミ:
利用者がアプリの楽しさを共有し、自然な形で利用者を増やす。</p>
<br>

|機能の実装方針| |
|---|---|
|技術スタック|開発環境: Docker|
|サーバサイド|Ruby on Rails 7系: 高速な開発サイクルを提供。
| |Ruby 3.2.2|
| |Rails 7.0.4.3|
|フロントエンド|ERBファイルを使用したHTML: フロントエンドはシンプルに黄色と黒で構成。|
| |JavaScript|
| |CSSフレームワーク:|
| |Bootstrap 5系: レスポンシブデザインを実装し、ユーザービリティを意識したシンプルなデザインを採用。|
|WebAPI|Google Maps API: 投稿に位置情報を追加。
| |LINE Messaging API: コメント通知を送信。|
| |OpenWeather API: 天気情報の取得。|
| |Google+ API: Googleログイン認証|
| |LINEログイン：　LINEログイン認証|
|画像アップロード|ActiveStorage: 画像のアップロード機能を提供。|
|インフラ|Webアプリケーションサーバ: Render|
| |ファイルサーバ: Amazon S3|
|その他|VCS: GitHub|
<br>


画面遷移図：　<a href="https://www.figma.com/board/I7TWuNN9Id1z2tpi35RQI0/%E7%84%A1%E9%A1%8C?node-id=0-1&t=HprCttfLc6lzSBqo-0">https://www.figma.com/board/I7TWuNN9Id1z2tpi35RQI0/%E7%84%A1%E9%A1%8C?node-id=0-1&t=HprCttfLc6lzSBqo-0</a>
<br>
ER図：　
```mermaid
erDiagram
    users ||--o{ posts: "ユーザーは複数の投稿を持つ"
    users ||--o{ comments: "ユーザーは複数のコメントを持つ"
    users ||--o{ like_posts: "ユーザーは複数のいいねを持つ"
    users ||--o{ user_locations: "ユーザーは複数のユーザー球場位置を持つ"
    users ||--o{ user_matches: "ユーザーは複数の試合情報を持つ"
    users ||--o| notifications: "ユーザーは１つの通知機能を持つ"
    users ||--o| one_time_codes: "ユーザーは1つのワンタイムコードを持つ"
    users ||--o{ sns_credentials: "ユーザーは複数の認証を持つ"
    posts ||--o{ comments: "投稿は複数のコメントを持つ"
    posts ||--o{ like_posts: "投稿は複数のいいねを持つ"
    posts ||--o| notifications: "投稿は１つの通知を持つ"
    locations ||--o{ user_locations: "球場位置は複数のユーザー球場位置を持つ"
    locations ||--o{ seats: "球場位置は複数のシート位置を持つ"
    events ||--o{ event_dates: "イベントは複数のイベント日時を持つ"
    matches ||--o{ user_matches: "試合は複数のユーザー試合を持つ"
    matches ||--o| events: "試合は０か1つのイベントを持つ"
    seats ||--o{ user_locations: "シート位置は複数のユーザー球場位置を持つ"


    users {
        bigint id PK "ユーザーID"
        string email "メールアドレス"
        string encrypted_password "暗号化パスワード"
        string reset_password_token "パスワードリセットトークン"
        datetime reset_password_sent_at "パスワードリセット送信時間"
        datetime remember_created_at "ログイン状態の記録クッキーの作成日"
        datetime created_at "作成日"
        datetime updated_at "更新日"
        string user_name "ユーザーネーム"
        string first_name "名"
        string last_name "姓"
        string avatar "ユーザー画像"
        string favorite_player "推し選手"
        integer favorite_viewing_block "いつもの場所"
        bigint location_id "シートID"
        integer role "権限"
        string line_user_id "LINEユーザーID"
        string oauth_token "OAuthトークン"
        datetime oauth_expires_at "OAuth有効期限"
        string confirmation_token "メールアドレス確認トークン"
        datetime confirmed_at "メールアドレス確認日時"
        datetime confirmation_sent_at "メールアドレス確認メール送信日時"
        string unconfirmed_email "未確認メールアドレス"
    }

    posts {
        bigint id PK ""
        bigint user_id FK ""
        text body ""
        string image ""
        datetime created_at ""
        datetime update_at ""
    }

    comments {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        bigint post_id FK "投稿ID"
        text body "本文"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    like_posts {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        bigint post_id FK "投稿ID"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    locations {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        string seat_name "座席名"
        jsonb points "座席範囲(表示)"
        integer location_type "座席タイプ"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    user_locations {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        bigint location_id FK "座席ID"
        integer offset_x "X座標のオフセット"
        integer offset_y "Y座標のオフセット"
        integer index "インデックス"
        integer icon "アイコン"
        date date "日付"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    seats {
        bigint id PK "ID"
        bigint location_id FK "座席ID"
        string seat_name "座席名"
        float latitude "緯度"
        float longitude "軽度"
        integer location_type "座席タイプ"
        jsonb spots "座席範囲"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    matches {
        bigint id PK "ID"
        bigint event_id FK "イベントID"
        integer opponent "対戦相手"
        string stadium "試合会場"
        integer result "勝敗"
        integer team_score "チームスコア"
        integer away_team_score "相手のスコア"
        datetime match_date "試合日程"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    user_matches {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        bigint match_id FK "試合ID"
        date date "日付"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    events {
        bigint id PK "ID"
        string title "イベントタイトル"
        string body "イベント内容"
        string detail_url "詳細URL"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    event_dates {
        bigint id PK "ID"
        bigint event_id FK "イベントID"
        date start_date "開始日"
        date end_date "終了日"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    notifications {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        bigint post_id FK "投稿ID"
        text message "メッセージ"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    one_time_codes {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        integer code "コード"
        datetime expires_at "有効期限"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

    sns_credentials {
        bigint id PK "ID"
        bigint user_id FK "ユーザーID"
        string provider "プロバイダー名"
        string uid "UID"
        datetime created_at "作成日"
        datetime updated_at "更新日"
    }

```
<br>
<br>

|機能紹介動画| |
|---|---|
| トップ画面 | 位置情報登録機能 |
|<a href="https://gyazo.com/e40b712d6ef42959429d03a46ccb4e8b"><img src="https://i.gyazo.com/e40b712d6ef42959429d03a46ccb4e8b.gif" alt="Image from Gyazo" width="400"/></a>|<a href="https://gyazo.com/3dbbccb95703e98736c2127e8047fb1d"><img src="https://i.gyazo.com/3dbbccb95703e98736c2127e8047fb1d.gif" alt="Image from Gyazo" width="400"/></a>|
|今日の試合情報、ユーザーの現在位置、最新の投稿が一目で確認できます。|位置情報を登録するから、現在位置を取得し、該当の座席名を表示します。自宅から応援も可能です。|
| | |
| 新規投稿機能 | アイコンから投稿の取得、ユーザー詳細 |
|<a href="https://gyazo.com/036e430189b5186e07ec8a9128495fe8"><img src="https://i.gyazo.com/036e430189b5186e07ec8a9128495fe8.gif" alt="Image from Gyazo" width="４００"/></a>|<a href="https://gyazo.com/be2d1cfb9a4f516b0cafe404bd2320fb"><img src="https://i.gyazo.com/be2d1cfb9a4f516b0cafe404bd2320fb.gif" alt="Image from Gyazo" width="400"/></a>|
|虎に熱い声援を送るから、新規投稿ができます。|甲子園球場上のアイコンをクリックしたら投稿が現れます。投稿ユーザーの名前をクリックすると、そのユーザーのページにリンクします。|
| | |
|観戦カレンダー|コメント機能|
|<a href="https://gyazo.com/55d64ec251146e8a22e5142bd9e11214"><img src="https://i.gyazo.com/55d64ec251146e8a22e5142bd9e11214.gif" alt="Image from Gyazo" width="400"/></a>|<a href="https://gyazo.com/66f989a60799c42c63c20d0eb6f6fc94"><img src="https://i.gyazo.com/66f989a60799c42c63c20d0eb6f6fc94.gif" alt="Image from Gyazo" width="400"/></a>|
|試合、イベント情報の閲覧と自身の観戦履歴を登録することができます。|他のユーザーの投稿にコメントができます。|
