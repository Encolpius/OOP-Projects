class Game 

    $colors = ["yellow", "blue", "red", "green", "purple", "black"]
    attr_accessor :code

    def initialize(player1)
        @player1 = player1
        @rounds = 1
        @peg_rounds = []
        @guess_rounds = []
        @indexes = {}
        @count = 0
    end

    def choose_players
        @code = []
        puts "Would you like to be the codemaker or codebreaker?"
        choice = gets.chomp.downcase.strip 
        loop do 
            if choice == "codebreaker" 
                begin_game 
            elsif choice == "codemaker" 
                create_code 
            else 
                "Invalid choice"
                choose_players
            end
        end
    end

    def create_code 
        puts "Choose four colors - no duplicates - from the following: Red, Blue, Yellow, Green, Purple, and Black."
        while @code.count < 4 
            @code << gets.chomp.downcase.strip
        end
        computer_guess
    end

    def begin_game
        @code = $colors.shuffle.slice(0,4) 
        play
    end

    def play
        puts
        puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        puts "The code has six colors: Red, Blue, Yellow, Green, Purple, and Black."
        puts "There are no duplicates. You have 10 rounds to guess the code or the computer wins!"
        puts "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
        puts
        loop do
            get_player_choices
            add_pegs
            board
            @rounds += 1
        end    
    end

    def board 
        @guess_rounds.each_with_index do |el, index|
            puts "ROUND #{index+1}: #{@guess_rounds[index].join(", ").ljust(30)}  |  #{@peg_rounds[index].join(", ")}"
        end
        puts
    end

    def get_player_choices 
        puts "ROUND #{@rounds}. #{@player1.name}, choose a color. Type 'colors' to get the list."
        @player_choices = []
        while @player_choices.count < 4
            guess = gets.chomp.downcase.strip
            is_valid?(guess)
        end
        @guess_rounds << @player_choices
    end

    def is_valid?(guess)
        if $colors.include?(guess)
            @player_choices << guess
        elsif guess.to_s == "colors" 
            @colors.each { |color| puts color }
            puts
        else 
            puts "Invalid selection. Please select a valid color."
        end    
    end

    def add_pegs
        pegs = []
        code_temp = @code.clone
        @player_choices.each_with_index do |el, index|
            if el == code_temp[index]
                pegs << "black"
                index = code_temp.index(el)
                code_temp[index] = "!"
            elsif code_temp.include?(el)
                pegs << "white"
                index = code_temp.index(el)
                code_temp[index] = "!"
            end
        end
        pegs.sort!
        code_broken?(pegs)
        @peg_rounds.push(pegs)
        puts
    end

    def code_broken?(pegs)
        if pegs.all? { |word| word == "black" } && pegs.count == 4
            puts "Congratulations! You have broken the code and won the game!"
            play_again?
        else
            false 
        end
    end

    def computer_guess
        guess = $colors.shuffle.slice(0,4)
        computer_peg_switch(guess)
    end

    def computer_peg_switch(guess)
        if @indexes.size > 0
            @indexes.each_pair do |key, value|
                guess[value] = key
            end
        end
        compute_pegs(guess)
    end

    def compute_pegs(guess)
        pegs = []
        code_temp = @code.clone
        guess.each_with_index do |el, index|
            if el == code_temp[index]
                pegs << "black"
                @indexes[el] = index
                index = code_temp.index(el)
                code_temp[index] = "!"
            elsif code_temp.include?(el)
                pegs << "white"
                index = code_temp.index(el)
                code_temp[index] = "!"
            end
        end
        keep_guessing
    end

    def keep_guessing
        while @indexes.count < 4
            @count += 1 
            if @count > 12
                beat_computer
            end 
            computer_guess
        end
        puts "The computer guessed in #{@count} tries!"
        play_again?
    end

    def beat_computer 
        puts "Congratulations! The computer was not able to guess your code!"
        play_again?
    end

    def play_again? 
        puts "Would you like to play again? Type 'yes' to continue, 'no' to exit. "
        next_game = gets.chomp.strip.downcase
        next_game == "yes" ? reset_game : exit
    end

    def reset_game 
        @rounds = 1
        @peg_rounds = []
        @guess_rounds = []
        @count = 0
        @indexes = {}
        choose_players  
    end

end