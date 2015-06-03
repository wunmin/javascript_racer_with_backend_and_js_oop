get "/" do
	erb :index
end

post "/games" do
	@player1 = Player.find_or_create_by(params[:player1])
	@player2 = Player.find_or_create_by(params[:player2])
	@game = Game.create
	GamePlayer.create(game: @game, player: @player1, player_num: 1)
	GamePlayer.create(game: @game, player: @player2, player_num: 2)
	erb :game
end

put "/games/:id" do
	@game = Game.find(params[:game_id])
	
	# Update the current game to "done"
	@game.update(done: true)

	# Update game_players table to indicate final position of both players and the winner
	# Update winner's info in game_players table
	# @winner = 1 or 2
	@winner = @game.game_players.find_by_player_num(params[:winner_id])
	@winner.update(final_position: 29, winner: true)
	@winner.save
	# Update loser's info in game_players table
	@loser = @game.game_players.where.not(player_num: params[:winner_id]).first
	@loser.update(final_position: params[:loser_index], winner: false)
	@loser.save
end

get "/games/:id" do
	# @winner is a Player object
	@game = Game.find(params[:id])
	@winner = @game.game_players.find_by_winner(true).player
	# @player1 and @player 2 are GamePlayer objects
	@player1 = @game.game_players.find_by_player_num(1)
	@player2 = @game.game_players.find_by_player_num(2)
	erb :result
end