class Game < ActiveRecord::Base
  require 'score_validator'
  belongs_to :player, class_name: 'User', foreign_key: 'player_id', required: true
  belongs_to :opponent, class_name: 'User', foreign_key: 'opponent_id', required: true

  #Model Validations
  validates :player, :opponent, :played_at, :player_score, :opponent_score, presence: true
  validates_with ScoreValidator, fields: [:player_score, :opponent_score]
  validates :player_score, :opponent_score, numericality: { only_integer: true, less_than: 22 }
end
