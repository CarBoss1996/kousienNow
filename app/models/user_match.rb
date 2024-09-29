class UserMatch < ApplicationRecord
  belongs_to :user
  belongs_to :match
  validate :one_match_per_day_per_user

  private

  def one_match_per_day_per_user
    if match && UserMatch.joins(:match).where(user_id: user_id, matches: { match_date: match.match_date }).exists?
      errors.add(:base, 'You can only register one match per day.')
    end
  end
end
