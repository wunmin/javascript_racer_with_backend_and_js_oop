class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |game|
      game.float :time_taken
      game.boolean :done
      game.timestamps
    end
  end
end
