class TicTacToe

    def initialize
        puts "What is the number of Player One?"
        player_one = gets.chomp
        @player_one = player_one
        puts "And what is the name of Player Two?"
        player_two = gets.chomp
        @player_two = player_two
        puts "Thanks #{@player_one} and #{@player_two}. It's time to play!"
    end

end
