# frozen_string_literal: true

class Match < ApplicationRecord
  belongs_to :event, optional: true
  has_many :user_matches
  has_many :users, through: :user_matches
  enum opponent: { 巨人: 0, 広島: 1, 中日: 2, ヤクルト: 3, DeNA: 4, オリックス: 5, ソフトバンク: 6, 日本ハム: 7, 西武: 8, ロッテ: 9, 楽天: 10 }
  STADIUM_NAMES = {
    'tokyo' => '東京ドーム',
    'mazda' => 'マツダスタジアム',
    'nagoya' => 'バンテリンドーム',
    'jingu' => '神宮球場',
    'yokohama' => '横浜スタジアム',
    'kyosera' => '京セラドーム',
    'hukuoka' => 'PayPayドーム',
    'sapporo' => 'エスコンフィールド',
    'seibu' => 'ベルーナドーム',
    'rotte' => 'ZOZOマリンスタジアム',
    'rakuten' => '楽天モバイルパーク宮城'
  }.freeze
  enum result: { 勝ち: 0, 負け: 1, 引き分け: 2, 雨天中止: 3 }

  attr_accessor :match_time

  before_save :merge_date_and_time

  def self.ransackable_attributes(_auth_object = nil)
    %w[match_date opponent]
  end

  private

  def merge_date_and_time
    return unless match_date && match_time

    time_parts = match_time.split(':').map(&:to_i)
    self.match_date = match_date.change(hour: time_parts[0], min: time_parts[1])
  end
end
