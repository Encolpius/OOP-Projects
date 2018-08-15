class Mastermind 

    require_relative 'player.rb'
    require_relative 'game.rb'

    puts "Play Mastermind and break the code!"
    player1 = Player.new
    game = Game.new(player1)
    game.begin_game

end