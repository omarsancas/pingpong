class AddDefaultToRating < ActiveRecord::Migration
  def change
    change_column :users, :rating, :float, default: 1000
  end
end
