# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
User.find_or_create_by!(email: 'aaa@aaa') do |user|
  user.user_name = 'aaa'
  user.last_name = 'aaa'
  user.first_name = 'aaa'
  user.password = 'aaaaaa'
  user.password_confirmation = 'aaaaaa'
end

locations = [
  { id: 1, location_type: :backnet, seat_name: 'backnet',
    points: [{ x: 36, y: 72 }, { x: 25, y: 81 }, { x: 32, y: 86 }, { x: 58, y: 86 }, { x: 67, y: 81 }, { x: 55, y: 72 }] },
  { id: 2, location_type: :smbc_seat, seat_name: 'smbc_seat',
    points: [{ x: 59, y: 68 }, { x: 67, y: 53 }, { x: 64, y: 61 }] },
  { id: 3, location_type: :ivy_seat, seat_name: 'ivy_seat',
    points: [{ x: 73, y: 54 }, { x: 81, y: 58 }, { x: 64, y: 71 }, { x: 72, y: 76 }] },
  { id: 4, location_type: :breeze_seat, seat_name: 'breeze_seat',
    points: [{ x: 25, y: 52 }, { x: 11, y: 58 }, { x: 21, y: 76 }, { x: 33, y: 67 }] },
  { id: 5, location_type: :first_base_alps, seat_name: 'first_base_alps',
    points: [{ x: 76, y: 32 }, { x: 71, y: 45 }, { x: 84, y: 51 }, { x: 90, y: 34 }] },
  { id: 6, location_type: :third_base_alps, seat_name: 'third_base_alps',
    points: [{ x: 2, y: 34 }, { x: 8, y: 52 }, { x: 21, y: 46 }, { x: 15, y: 31 }] },
  { id: 7, location_type: :right_outfield, seat_name: 'right_outfield',
    points: [{ x: 55, y: 2 }, { x: 54, y: 11 }, { x: 69, y: 15 }, { x: 77, y: 24 }, { x: 89, y: 26 }, { x: 78, y: 8 }] },
  { id: 8, location_type: :left_outfield, seat_name: 'left_outfield',
    points: [{ x: 38, y: 2 }, { x: 38, y: 11 }, { x: 23, y: 16 }, { x: 15, y: 24 }, { x: 4, y: 26 }, { x: 12, y: 10 }] },
  { id: 9, location_type: :home_cheering, seat_name: 'home_cheering',
    points: [{ x: 30, y: 26 }, { x: 30, y: 37 }, { x: 60, y: 37 }, { x: 60, y: 26 }] }
]

locations.each do |location|
  Location.find_or_create_by!(location_type: location[:location_type], seat_name: location[:seat_name]) do |loc|
    loc.points = location[:points].to_json
  end
end

seats = [
  { id: 1, location_id: 1, location_type: 'backnet', seat_name: 'backnet',
    spots: [{ lat: 34.722062259253946, lng: 135.36080775915224 }, { lat: 34.721825961386614, lng: 135.3613683703013 }, { lat: 34.721912604016396, lng: 135.36145142380488 }, { lat: 34.72191785508195, lng: 135.36164787728447 }, { lat: 34.72185878057524, lng: 135.36175329134667 }, { lat: 34.722176469647735, lng: 135.36231070813025 }, { lat: 34.72239438789241, lng: 135.36196571665388 }, { lat: 34.722331375446956, lng: 135.3610217816422 }] },
  { id: 2, location_id: 2, location_type: 'smbc_seat', seat_name: 'smbc_seat',
    spots: [{ lat: 34.72187874116491, lng: 135.36179821195276 }, { lat: 34.7214670896035, lng: 135.36214140786504 }, { lat: 34.72154942007975, lng: 135.36226949055 }, { lat: 34.72196916926612, lng: 135.36191972629493 }] },
  { id: 3, location_id: 3, location_type: 'ivy_seat', seat_name: 'ivy_seat',
    spots: [{ lat: 34.72156156719225, lng: 135.3605354480459 }, { lat: 34.72139420681841, lng: 135.36107241007133 }, { lat: 34.72185309735701, lng: 135.3613384279555 }, { lat: 34.72207309397672, lng: 135.36079325550156 }] },
  { id: 4, location_id: 4, location_type: 'breeze_seat', seat_name: 'breeze_seat',
    spots: [{ lat: 34.721971868610915, lng: 135.36193122089486 }, { lat: 34.7215386226449, lng: 135.36226949055 }, { lat: 34.72168438789625, lng: 135.3626340335764 }, { lat: 34.72215947285756, lng: 135.36226784846428 }] },
  { id: 5, location_id: 5, location_type: 'first_base_alps', seat_name: 'first_base_alps',
    spots: [{ lat: 34.721562916864194, lng: 135.3605453005603 }, { lat: 34.721009546603405, lng: 135.36037616573273 }, { lat: 34.72095150999563, lng: 135.36091969610092 }, { lat: 34.72138475903816, lng: 135.36104777878592 }] },
  { id: 6, location_id: 6, location_type: 'third_base_alps', seat_name: 'third_base_alps',
    spots: [{ lat: 34.721448194066305, lng: 135.36218574417896 }, { lat: 34.72106083473515, lng: 135.36242384660613 }, { lat: 34.72117690775651, lng: 135.36290005146049 }, { lat: 34.72168978659783, lng: 135.36263567566203 }] },
  { id: 7, location_id: 7, location_type: 'right_outfield', seat_name: 'right_outfield',
    spots: [{ lat: 34.72100954659191, lng: 135.3604057232753 }, { lat: 34.72046427080976, lng: 135.36078668715876 }, { lat: 34.72033604949718, lng: 135.36160937209678 }, { lat: 34.72069641836452, lng: 135.36157981455412 }, { lat: 34.72075715453582, lng: 135.36117257729936 }, { lat: 34.7209744546944, lng: 135.36091476984373 }] },
  { id: 8, location_id: 8, location_type: 'left_outfield', seat_name: 'left_outfield',
    points: [{ lat: 34.720709745341196, lng: 135.3617563256627 }, { lat: 34.72038671554692, lng: 135.3618378628127 }, { lat: 34.72052611445111, lng: 135.36266301877117 }, { lat: 34.72114670479741, lng: 135.3628505542163 }, { lat: 34.72105287934201, lng: 135.36237763874604 }, { lat: 34.720822336342174, lng: 135.3621477039829 }] },
  { id: 9, location_id: 9, location_type: 'home_cheering', seat_name: 'home_cheering' }
]

seats.each do |seat|
  Seat.find_or_create_by!(id: seat[:id]) do |s|
    s.location_id = seat[:location_id]
    s.location_type = seat[:location_type]
    s.seat_name = seat[:seat_name]
    s.spots = seat[:spots].to_json
  end
end

matches = [
  { match_date: '2024-07-02 18:00', opponent: Match.opponents[:広島], stadium: 'mazda', result: 0, team_score: 3,
    away_team_score: 0 },
  { match_date: '2024-07-03 18:00', opponent: Match.opponents[:広島], stadium: 'mazda', result: 0, team_score: 2,
    away_team_score: 1 },
  { match_date: '2024-07-04 18:00', opponent: Match.opponents[:広島], stadium: 'mazda', result: 1, team_score: 5,
    away_team_score: 7 },
  { match_date: '2024-07-05 18:00', opponent: Match.opponents[:DeNA], result: 1, team_score: 1, away_team_score: 2 },
  { match_date: '2024-07-06 18:00', opponent: Match.opponents[:DeNA], result: 0, team_score: 2, away_team_score: 1 },
  { match_date: '2024-07-07 18:00', opponent: Match.opponents[:DeNA], result: 0, team_score: 6, away_team_score: 5 },
  { match_date: '2024-07-09 18:00', opponent: Match.opponents[:ヤクルト], result: 0, team_score: 2, away_team_score: 1 },
  { match_date: '2024-07-10 18:00', opponent: Match.opponents[:ヤクルト], result: 0, team_score: 4, away_team_score: 1 },
  { match_date: '2024-07-12 18:00', opponent: Match.opponents[:中日], stadium: 'nagoya', result: 1, team_score: 0,
    away_team_score: 3 },
  { match_date: '2024-07-13 14:00', opponent: Match.opponents[:中日], stadium: 'nagoya', result: 1, team_score: 8,
    away_team_score: 10 },
  { match_date: '2024-07-14 13:30', opponent: Match.opponents[:中日], stadium: 'nagoya', result: 0, team_score: 6,
    away_team_score: 2 },
  { match_date: '2024-07-15 14:00', opponent: Match.opponents[:巨人], stadium: 'tokyo', result: 0, team_score: 2,
    away_team_score: 0 },
  { match_date: '2024-07-16 18:00', opponent: Match.opponents[:巨人], stadium: 'tokyo', result: 1, team_score: 1,
    away_team_score: 2 },
  { match_date: '2024-07-17 18:00', opponent: Match.opponents[:巨人], stadium: 'tokyo', result: 1, team_score: 3,
    away_team_score: 4 },
  { match_date: '2024-07-19 18:00', opponent: Match.opponents[:広島], result: 1, team_score: 0, away_team_score: 1 },
  { match_date: '2024-07-20 18:00', opponent: Match.opponents[:広島], result: 1, team_score: 0, away_team_score: 1 },
  { match_date: '2024-07-21 18:00', opponent: Match.opponents[:広島], result: 0, team_score: 12, away_team_score: 3 },
  { match_date: '2024-07-26 18:00', opponent: Match.opponents[:中日], result: 0, team_score: 5, away_team_score: 1 },
  { match_date: '2024-07-27 18:00', opponent: Match.opponents[:中日], result: 0, team_score: 7, away_team_score: 3 },
  { match_date: '2024-07-28 18:00', opponent: Match.opponents[:中日], result: 0, team_score: 4, away_team_score: 3 },
  { match_date: '2024-07-30 18:00', opponent: Match.opponents[:巨人], result: 0, team_score: 5, away_team_score: 1 },
  { match_date: '2024-07-31 18:00', opponent: Match.opponents[:巨人], result: 0, team_score: 9, away_team_score: 6 },
  { match_date: '2024-08-01 18:00', opponent: Match.opponents[:巨人], result: 0, team_score: 9, away_team_score: 2 },
  { match_date: '2024-08-02 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 1, team_score: 4,
    away_team_score: 2 },
  { match_date: '2024-08-03 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 1, team_score: 4,
    away_team_score: 10 },
  { match_date: '2024-08-04 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 0, team_score: 4,
    away_team_score: 0 },
  { match_date: '2024-08-06 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'jingu', result: 1, team_score: 4,
    away_team_score: 5 },
  { match_date: '2024-08-07 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'jingu', result: 1, team_score: 0,
    away_team_score: 4 },
  { match_date: '2024-08-08 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'jingu', result: 0, team_score: 6,
    away_team_score: 3 },
  { match_date: '2024-08-09 18:00', opponent: Match.opponents[:広島], stadium: 'kyosera', result: 1, team_score: 3,
    away_team_score: 6 },
  { match_date: '2024-08-10 18:00', opponent: Match.opponents[:広島], stadium: 'kyosera', result: 1, team_score: 1,
    away_team_score: 5 },
  { match_date: '2024-08-11 18:00', opponent: Match.opponents[:広島], stadium: 'kyosera', result: 0, team_score: 4,
    away_team_score: 0 },
  { match_date: '2024-08-12 18:00', opponent: Match.opponents[:巨人], stadium: 'tokyo', result: 1, team_score: 0,
    away_team_score: 1 },
  { match_date: '2024-08-13 18:00', opponent: Match.opponents[:巨人], stadium: 'tokyo', result: 0, team_score: 8,
    away_team_score: 5 },
  { match_date: '2024-08-14 18:00', opponent: Match.opponents[:巨人], stadium: 'tokyo', result: 1, team_score: 0,
    away_team_score: 4 },
  { match_date: '2024-08-16 18:00', opponent: Match.opponents[:中日], stadium: 'nagoya', result: 1, team_score: 1,
    away_team_score: 2 },
  { match_date: '2024-08-17 14:00', opponent: Match.opponents[:中日], stadium: 'nagoya', result: 3, team_score: 5,
    away_team_score: 5 },
  { match_date: '2024-08-18 13:30', opponent: Match.opponents[:中日], stadium: 'nagoya', result: 1, team_score: 4,
    away_team_score: 8 },
  { match_date: '2024-08-20 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'kyosera', result: 0, team_score: 8,
    away_team_score: 3 },
  { match_date: '2024-08-21 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'kyosera', result: 0, team_score: 10,
    away_team_score: 4 },
  { match_date: '2024-08-22 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'kyosera', result: 1, team_score: 2,
    away_team_score: 5 },
  { match_date: '2024-08-23 18:00', opponent: Match.opponents[:広島], stadium: 'mazda', result: 0, team_score: 3,
    away_team_score: 1 },
  { match_date: '2024-08-24 18:00', opponent: Match.opponents[:広島], stadium: 'mazda', result: 1, team_score: 1,
    away_team_score: 2 },
  { match_date: '2024-08-25 18:00', opponent: Match.opponents[:広島], stadium: 'mazda', result: 0, team_score: 7,
    away_team_score: 5 },
  { match_date: '2024-08-27 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 1, team_score: 4,
    away_team_score: 10 },
  { match_date: '2024-08-28 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 1, team_score: 2,
    away_team_score: 3 },
  { match_date: '2024-08-29 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 3 },
  { match_date: '2024-08-30 18:00', opponent: Match.opponents[:巨人], result: 3 },
  { match_date: '2024-08-31 18:00', opponent: Match.opponents[:巨人], result: 0, team_score: 4, away_team_score: 2 },
  { match_date: '2024-09-01 18:00', opponent: Match.opponents[:巨人], result: 1, team_score: 1, away_team_score: 3 },
  { match_date: '2024-09-03 18:00', opponent: Match.opponents[:中日], result: 0, team_score: 4, away_team_score: 1 },
  { match_date: '2024-09-04 18:00', opponent: Match.opponents[:中日], result: 0, team_score: 9, away_team_score: 4 },
  { match_date: '2024-09-05 18:00', opponent: Match.opponents[:中日], result: 0, team_score: 2, away_team_score: 1 },
  { match_date: '2024-09-06 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'jingu', result: 0, team_score: 9,
    away_team_score: 1 },
  { match_date: '2024-09-07 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'jingu', result: 0, team_score: 6,
    away_team_score: 0 },
  { match_date: '2024-09-08 17:00', opponent: Match.opponents[:ヤクルト], stadium: 'jingu', result: 1, team_score: 3,
    away_team_score: 5 },
  { match_date: '2024-09-10 18:00', opponent: Match.opponents[:DeNA], result: 0, team_score: 7, away_team_score: 2 },
  { match_date: '2024-09-11 18:00', opponent: Match.opponents[:DeNA], result: 1, team_score: 3, away_team_score: 4 },
  { match_date: '2024-09-12 18:00', opponent: Match.opponents[:DeNA], result: 3 },
  { match_date: '2024-09-13 18:00', opponent: Match.opponents[:広島], result: 0, team_score: 7, away_team_score: 3 },
  { match_date: '2024-09-14 14:00', opponent: Match.opponents[:広島], result: 0, team_score: 4, away_team_score: 3 },
  { match_date: '2024-09-15 18:00', opponent: Match.opponents[:ヤクルト], result: 0, team_score: 2, away_team_score: 1 },
  { match_date: '2024-09-16 14:00', opponent: Match.opponents[:ヤクルト], result: 0, team_score: 3, away_team_score: 0 },
  { match_date: '2024-09-18 18:00', opponent: Match.opponents[:中日], stadium: 'nagoya', result: 0, team_score: 8,
    away_team_score: 3 },
  { match_date: '2024-09-20 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 1, team_score: 6,
    away_team_score: 9 },
  { match_date: '2024-09-21 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama', result: 0, team_score: 6,
    away_team_score: 5 },
  { match_date: '2024-09-22 18:00', opponent: Match.opponents[:巨人], result: 0, team_score: 1, away_team_score: 0 },
  { match_date: '2024-09-23 14:00', opponent: Match.opponents[:巨人], result: 1, team_score: 0, away_team_score: 1 },
  { match_date: '2024-09-27 18:00', opponent: Match.opponents[:広島], stadium: 'mazda', result: 1, team_score: 2,
    away_team_score: 3 },
  { match_date: '2024-09-28 18:00', opponent: Match.opponents[:ヤクルト], stadium: 'jingu', result: 1, team_score: 2,
    away_team_score: 7 },
  { match_date: '2024-09-29 18:00', opponent: Match.opponents[:DeNA], result: 0, team_score: 7,
  away_team_score: 6 },
  { match_date: '2024-09-30 18:00', opponent: Match.opponents[:DeNA], result: 1, team_score: 0,
  away_team_score: 2 },
  { match_date: '2024-10-03 18:00', opponent: Match.opponents[:DeNA], stadium: 'yokohama' }
]

matches.each do |match|
  match[:match_date] = ActiveSupport::TimeZone['Tokyo'].parse(match[:match_date])
  existing_match = Match.find_by(match_date: match[:match_date], opponent: match[:opponent])
  if existing_match
    existing_match.update!(match)
  else
    Match.create!(match)
  end

  events = [
    { event_title: 'からあげ祭', start_date: '2024-04-16', end_date: '2024-04-21' },
    { event_title: 'からあげ祭', start_date: '2024-09-10', end_date: '2024-09-13' },
    { event_title: 'からあげ祭', start_date: '2024-09-15', end_date: '2024-09-16' },
    { event_title: 'KIDSスペシャルデー', body: '入場券をお持ちの小学生以下のお子様先着5,000名様に「KIDSレッスンバッグ」をプレゼント！', start_date: '2024-04-20',
      end_date: '2024-04-20' },
    { event_title: 'KIDSスペシャルデー', body: '入場券をお持ちの小学生以下のお子様先着5,000名様に「KIDSレッスンバッグ」をプレゼント！', start_date: '2024-06-08',
      end_date: '2024-06-08' },
    { event_title: 'KIDSスペシャルデー', body: '入場券をお持ちの小学生以下のお子様先着5,000名様に「KIDSレッスンバッグ」をプレゼント！', start_date: '2024-08-21',
      end_date: '2024-08-21' },
    { event_title: '肉祭', start_date: '2024-07-19', end_date: '2024-07-21' },
    { event_title: 'Family with Tigers Day', body: '監督・コーチ・選手がイベント限定ユニフォームを着用し、試合に臨みます！来場者プレゼントあり',
      start_date: '2024-08-09', end_date: '2024-08-11', detail_url: 'https://hanshintigers.jp/lp/event_family_with_tigers2024/' },
    { event_title: 'Family with Tigers Day', body: '監督・コーチ・選手がイベント限定ユニフォームを着用し、試合に臨みます！来場者プレゼントあり',
      start_date: '2024-09-01', end_date: '2024-09-01', detail_url: 'https://hanshintigers.jp/lp/event_family_with_tigers2024/' },
    { event_title: 'TORACO DAY', start_date: '2024-08-20', end_date: '2024-08-20',
      detail_url: 'https://hanshintigers.jp/toraco/' },
    { event_title: 'Family with Tigers Day', body: '監督・コーチ・選手がイベント限定ユニフォームを着用し、試合に臨みます！来場者プレゼントあり',
      start_date: '2024-08-09', end_date: '2024-08-11' },
    { event_title: '伝統の一戦', body: '伝統の一戦座布団※5月25日(土)、5月26日(日)の入場者プレゼントの実施はございません。', start_date: '2024-05-24',
      end_date: '2024-05-26', detail_url: 'https://hanshintigers.jp/news/topics/info_9278.html' },
    { event_title: '生ビールワンコインナイター', start_date: '2024-06-07', end_date: '2024-06-07' },
    { event_title: '生ビールワンコインナイター', start_date: '2024-07-10', end_date: '2024-07-10' },
    { event_title: '甲子園ビアフェスタ', start_date: '2024-06-21', end_date: '2024-06-23' },
    { event_title: '甲子園ビアフェスタ', start_date: '2024-08-30', end_date: '2024-09-01' },
    { event_title: 'トラフェス', body: '観戦×フェスのイベント！当日「トラフェスフードタオル」をプレゼント！', start_date: '2024-06-22',
      end_date: '2024-06-22' },
    { event_title: 'トラフェス', body: '観戦×フェスのイベント！当日「トラフェスTシャツ」をプレゼント！', start_date: '2024-06-23',
      end_date: '2024-06-23' },
    { event_title: '夏のこどもまつり', body: "入場券をお持ちの小学生以下のお子様先着7,000名様に「KIDSハッピ」をプレゼント！
    夏休みの思い出にご家族みなさまで楽しんでいただけるような演出・イベントを予定しております！
    この夏最初の思い出は阪神甲子園球場で！", start_date: '2024-07-05', end_date: '2024-07-07', detail_url: 'https://hanshintigers.jp/lp/summer_kidsfes_2024/' },
    { event_title: 'チーズ祭り', start_date: '2024-07-05', end_date: '2024-07-07' },
    { event_title: 'ウル虎の夏2024', start_date: '2024-04-16', end_date: '2024-04-18',
      detail_url: 'https://hanshintigers.jp/news/topics/info_9164.html' },
    { event_title: 'ウル虎の夏2024', start_date: '2024-07-19', end_date: '2024-07-21',
      detail_url: 'https://hanshintigers.jp/news/topics/info_9164.html' },
    { event_title: 'ウル虎の夏2024', start_date: '2024-07-26', end_date: '2024-07-28',
      detail_url: 'https://hanshintigers.jp/news/topics/info_9164.html' },
    { event_title: '粉もん祭', start_date: '2024-07-26', end_date: '2024-07-28' },
    { event_title: 'KOSHIEN CLASSIC SERIES 100TH ANNIVERSARY', body: "阪神甲子園球場開場100周年の特別シリーズ！各種イベントに加え、「超満員プロジェクト」として1・3塁の両アルプス席を座席幅が狭い仕様(2019年シーズンまでの座席幅)に変更し、販売座席数を拡大します！来たる100周年をより多くの野球ファンの皆様と迎えたいという想いから、47,000人規模のお客様にご来場いただけるよう準備を整えて開催いたします！超満員のスタンドで記念すべき節目を盛り上げましょう！
    ※甲子園100周年記念ボール（硬式球）は、先着10,000名様の小学生以下のお子様限定となります。", start_date: '2024-07-30', end_date: '2024-08-01', datail_url: 'https://koshien.hanshin.co.jp/classic_series_2024/' },
    { event_title: '「選手なりきりお面」をプレゼント！', start_date: '2024-09-14', end_date: '2024-09-14' },
    { event_title: '「トラフェスTシャツ」をプレゼント！', start_date: '2024-09-29', end_date: '2024-09-29' }
  ]
  events.each do |event|
    existing_event = Event.find_by(title: event[:event_title])
    unless existing_event
      new_event = Event.create!(title: event[:event_title], body: event[:body], detail_url: event[:detail_url])
      new_event.event_dates.create!(start_date: event[:start_date], end_date: event[:end_date])
    end
  end
end
