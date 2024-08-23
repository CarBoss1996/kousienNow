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
<br>
<br>

|機能紹介| |
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
