class Match < ApplicationRecord
  belongs_to :event, optional: true
  enum opponent: { 巨人: 0, 広島: 1, 中日: 2, ヤクルト: 3, DeNA: 4, オリックス: 5, ソフトバンク: 6, 日本ハム: 7, 西武: 8, ロッテ: 9, 楽天: 10 }
  STADIUM_NAMES = {
    "tokyo" => "東京ドーム",
    "mazda" => "マツダスタジアム",
    "nagoya" => "バンテリンドーム",
    "jingu" => "神宮球場",
    "yokohama" => "横浜スタジアム",
    "kyosera" => "京セラドーム",
    "hukuoka" => "PayPayドーム",
    "sapporo" => "エスコンフィールド",
    "seibu" => "ベルーナドーム",
    "rotte" => "ZOZOマリンスタジアム",
    "rakuten" => "楽天モバイルパーク宮城"
  }
end
