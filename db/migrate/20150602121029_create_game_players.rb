class CreateGamePlayers < ActiveRecord::Migration
  def change
    create_table :game_players do |game_player|
      game_player.belongs_to :player
      game_player.belongs_to :game
      game_player.integer :player_num
      game_player.integer :final_position
      game_player.boolean :winner
      game_player.timestamps
    end
    add_index :game_players, [:player_id, :game_id]
  end
end
