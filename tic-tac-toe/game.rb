class Game

    require_relative 'board.rb'
    attr_reader :grid_placement, :choices

    def initialize(player1, player2, board)
        @player1 = player1 
        @player2 = player2
        @board = board
        @ttt_board = @board.create_board
        @current_player = @player1
    end

    def play_game
        @count = 0
        while !winner? || !full? 
            print "#{@current_player.name}, make your pick: "
            @turn = gets.chomp.strip
            $grid.include?(@turn) ? $grid : error 
            @current_player.choices.push(@turn)
            update = $grid.index(@turn)
            $grid[update] = @current_player.grid_placement
            @ttt_board = @board.create_board
            winner?
            @count += 1
            @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
            full?
        end
    end

    def error 
        puts "This is not a valid answer. Please try again!"
        play_game
    end

    def winner?
        result = false
        win_conditions = [["1", "2", "3"], 
                          ["4", "5", "6"], 
                          ["7", "8", "9"],
                          ["1", "5", "9"],
                          ["3", "5", "7"],
                          ["1", "4", "7"],
                          ["2", "5", "8"],
                          ["3", "6", "9"]]
        win_conditions.each do |check|
            if check.all? { |win| @current_player.choices.index(win) }
                win
            end
        end
    end

    def full?
        if @count == 9
             puts "Sorry, no one won! Try again!"
             reset
        end
    end

    def win 
        puts "Congratulations, #{@current_player.name}! You've won a fabulous victory!"
        play_again = print "Types 'yes' to play again or 'exit' to leave. "
        reset_game = gets.chomp.downcase.strip
        reset_game == "yes" ? reset : exit
    end

    def reset
        puts "Resetting the board..."
        $grid = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        @current_player = @player1
        @ttt_board = @board.create_board
        @player1.choices.clear 
        @player2.choices.clear
        play_game
    end

end