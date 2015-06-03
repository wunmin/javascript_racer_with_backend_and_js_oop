class GamePlayer < ActiveRecord::Base
  belongs_to :player
  belongs_to :game
  validate :not_more_than_two_players, on: :create

  def not_more_than_two_players
    if game.players.length > 2
      errors.add(:game, " cannot have more than 2 players.")
    end
  end
end
