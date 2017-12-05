class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  def index
    @games = Game.includes(:opponent, :player).played_by(current_user.id).order(played_at: :desc)
  end

  # GET /games/1
  def show
  end

  # GET /games/new
  def new
    @game = Game.new(played_at: Time.zone.now.to_date)
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.player = current_user

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game)
      .permit(:player_id, :opponent_id, :played_at, :player_score, :opponent_score)
      .merge!(played_at: played_at)
    end

    def played_at
      if (played_at = params[:played_at])
        Date.civil(played_at[:year].to_i, played_at[:month].to_i, played_at[:day].to_i)
      end
    end
end
