class TicTacToe

    def initialize
        @players = []
        @first_player_choices = []
        @second_player_choices = []
        puts "What is the number of Player One?"
        @player_one = gets.chomp
        puts "And what is the name of Player Two?"
        @player_two = gets.chomp
        puts "Thanks #{@player_one} and #{@player_two}. It's time to play!"
        @players.push(@player_one, @player_two)
        @grid = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
        self.initialize_game
    end

    def initialize_game
        @current_player = @player_one
        puts "#{@current_player}, the grid is labeled below...good luck!"
        @board = self.board
        self.guess
    end

    def board
        tic_tac_toe_board = @grid.each_slice(3) do |x|
            x.each do |y|
                print y + " | "
            end
            puts ""
            puts "--- ---- ----"
        end
    end

    def guess
        puts "#{@current_player}, pick a number from the grid!"
        @guess = gets.upcase.chomp
        @current_player == @player_one ? 
                    @first_player_choices.push(@guess) : @second_player_choices.push(@guess)
        @current_player == @player_one ? @current_choices = @first_player_choices : 
                                          @current_choices = @second_player_choices
        self.check
    end

    def check
        @grid.include?(@guess) ? self.update_grid : self.error
    end

    def update_grid 
        update = @grid.index(@guess)
        if @current_player == @player_one
            @grid[update] = " X"
        else 
            @grid[update] = " O"
        end
        @board = self.board
        self.check_for_win
        @current_player = self.switch_players
        self.guess
    end

    def switch_players 
        @current_player == @player_two ? @current_player = @player_one : @current_player = @player_two 
    end

    def error
        puts "This is not a valid choice. Please try again."
        self.guess
    end

    def check_for_win
        win_conditions = [["A1", "A2", "A3"], 
                          ["B1", "B2", "B3"], 
                          ["C1", "C2", "C3"],
                          ["A1", "B2", "C3"],
                          ["A3", "B2", "C1"],
                          ["A1", "B1", "C1"],
                          ["A1", "B2", "C2"],
                          ["A3", "B3", "C3"]]
         win_conditions.each do |condition_check|
             if condition_check.all? { |condition| @current_choices.index(condition) }
               self.win 
            end
        end
    end

    def win 
        puts "#{@current_player} IS THE WINNER!"
        puts "Do you want to play again?"
        play_again = gets.chomp 
        play_again == "yes" ? exit : exit
    end
end

