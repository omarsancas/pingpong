class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :player, index: true, foreign_key: true
      t.references :opponent, index: true, foreign_key: true
      t.datetime :played_at
      t.integer :player_score
      t.integer :opponent_score

      t.timestamps null: false
    end
  end
end
