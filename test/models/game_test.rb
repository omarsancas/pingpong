require 'test_helper'

class GameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Game should have the necessary required validators" do
    game = Game.new
    assert_not game.valid?
    assert_equal [:player, :opponent, :played_at, :player_score, :opponent_score], game.errors.keys
  end

  test "Game should have numeric scores" do
    game = games(:game_1)
    game[:player_score] = 'x'
    game[:opponent_score] = 'x'

    assert_not game.valid?
    assert_equal ["is not a number"], game.errors.messages[:player_score]
    assert_equal ["is not a number"], game.errors.messages[:opponent_score]
  end

  test "Game should have integer scores" do
    game = games(:game_1)
    game[:player_score] = 1.1
    game[:opponent_score] = 1.2

    assert_not game.valid?
    assert_equal ["must be an integer"], game.errors.messages[:player_score]
    assert_equal ["must be an integer"], game.errors.messages[:opponent_score]
  end

end
