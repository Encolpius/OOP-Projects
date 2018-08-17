class Computer 

    def first_guess
        guess = $colors.shuffle.slice(0,4)
        compute_pegs(guess)
    end

    def compute_pegs(guess)
        pegs = []
        code_temp = @code.clone
        guess.each_with_index do |el, index|
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
        print pegs
    end

end