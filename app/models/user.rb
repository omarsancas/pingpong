class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable, :validatable

  has_many :games_as_player, foreign_key: 'player_id', class_name: 'Game'
  has_many :games_as_opponent, foreign_key: 'opponent_id', class_name: 'Game'

  def played_games
    games_as_player + games_as_opponent
  end
end
