class Game < ActiveRecord::Base
  require 'score_validator'
  belongs_to :player, class_name: 'User', foreign_key: 'player_id', required: true
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id', required: true

  #Model Validations
  validates :player, :opponent, :played_at, :player_score, :opponent_score, presence: true
  validates_with ScoreValidator, fields: [:player_score, :opponent_score]
  validates :player_score, :opponent_score, numericality: { only_integer: true, less_than: 22 }

  def self.played_by(user_id)
    where(%{player_id = :id OR opponent_id = :id}, id: user_id)
  end

  def score
    "#{player_score} - #{opponent_score}"
  end

  def won?
    (opponent_score < player_score)
  end

  def compute_results(k_value = 32)
    player_expectation = 1/(1+10**((opponent.rating - player.rating)/400.0))
    opponent_expectation = 1/(1+10**((player.rating - opponent.rating)/400.0))

    result = won? ? 1 : 0
    player_rating = player.rating + (k_value*(result - player_expectation))
    opponent_rating = opponent.rating + (k_value*((1 - result) - opponent_expectation))

    # Using transaction for safety reasons
    User.transaction do
      player.update!(rating: player_rating)
      opponent.update!(rating: opponent_rating)
    end
  end
end
