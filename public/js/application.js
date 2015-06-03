$(document).ready(function() {
  // Player class constructor
  function Player(playerNum) {
      // New Player constructor
      this.playerNum = playerNum;

      // Player movePlayer method
      this.movePlayer = function() {
          this.playerPosition = $("#row" + playerNum + " .active").index();
          $("#row" + this.playerNum + " td").eq(this.playerPosition).removeClass("active");
          $("#row"+ this.playerNum + " td").eq(this.playerPosition + 1).addClass("active");
      };
  }

  // Game class constructor
  function Game(player1, player2) {
      // New Game constructor
      this.player1 = player1;
      this.player2 = player2;

      // Game method to check if one player has won
      this.hasWon = function(playerNum) {
          var position = $("#row" + playerNum + " .active").index();
          if (position + 1 === $("#row" + playerNum + " td").length) {
              return true
          }
      };

      // Game method to send winner's information to ActiveRecord
      this.submitWinner = function(playerNum) {
          var gameId = $("#game").data("game-id");

          // Loser information
          var loser;
          playerNum === 1 ? loser = 2 : loser = 1;
          var loserIndex = $("#row" + loser + " .active").index();

          // Send information from Javascript to backend
          $.ajax({
            type: "PUT",
            url: "/games/" + gameId,
            data: {"game_id": gameId,
                   "winner_id": playerNum,
                   "loser_index": loserIndex
            }
          }).done(function(response){
            window.location = "/games/" + gameId
          })    
      }

      // Game method to move player, check if anyone has won and send game information to backend for each keyup event
      this.onKeyUp = function(keyCode) {
          // Check to see which player is playing based on keyCode and move relevant player
          if (keyCode === 81) {
              this.player1.movePlayer();
          }
          else if (keyCode === 80) {
              this.player2.movePlayer();
          }
          // Check if any one winner has won and submit the game's information to backend
          if (this.hasWon(1)) {
              this.submitWinner(1);
          }
          else if (this.hasWon(2)) {
              this.submitWinner(2);
          }

      }
  }

  $("#row1 td:first-child").addClass("active");
  $("#row2 td:first-child").addClass("active");

  var player1 = new Player(1);
  var player2 = new Player(2);
  var game = new Game(player1, player2);

  $(document).on("keyup", function(event) {
      game.onKeyUp(event.keyCode);
  })
})