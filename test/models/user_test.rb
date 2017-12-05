require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "played_games should return all matches an user participated" do
    user = users(:user_1)
    games = games(:game_1, :game_2)

    assert_equal user.played_games, games
  end
end
