class TicTacToe

    require_relative 'players.rb'
    require_relative 'game.rb'

    puts "Time to play some Tic-Tac-Toe! Let's start with getting our two players:"
    player1 = Players.new
    player2 = Players.new 
    board = Board.new
    game = Game.new(player1, player2, board)
    game.play_game

end 