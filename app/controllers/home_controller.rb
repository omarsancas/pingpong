class HomeController < ApplicationController
  def index
    @players = User.order(rating: :desc)
  end

  def history
  end

  def log
  end
end
