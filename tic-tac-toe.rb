class TicTacToe

    def initialize
        @grid = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3"]
        @players = [];
        puts "What is the number of Player One?"
        @player_one = gets.chomp
        puts "And what is the name of Player Two?"
        @player_two = gets.chomp
        puts "Thanks #{@player_one} and #{@player_two}. It's time to play!"
        @players.push(@player_one, @player_two)
        self.initialize_game
    end

    def initialize_game
        @current_player = self.randomize
        puts "#{@current_player}, you are first. The grid is labeled below...good luck!"
        @board = self.board
        self.guess
    end

    def randomize
        @players.sample
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
        puts "Pick a number from the grid!"
        @guess = gets.chomp
        self.check
    end

    def check
        @grid.any? { |x| x.include?(@guess)} ? self.update_grid : self.error
    end

    def update_grid 
        update = @grid.index(@guess)
        @grid[update] = " X"
        @board = self.board
        self.guess
    end

    def error
        puts "This is not a valid choice. Please try again."
        self.guess
    end
end

