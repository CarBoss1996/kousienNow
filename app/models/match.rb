class Match < ApplicationRecord
  belongs_to :team
  belongs_to :event
  enum opponent: { 巨人: 0, 広島: 1, 中日: 2, ヤクルト: 3, DeNA: 4, オリックス: 5, ソフトバンク: 6, 日本ハム: 6, 西武: 7, ロッテ: 8, 楽天: 9 }
end
