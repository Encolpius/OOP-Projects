class Player 

    attr_reader :name

    def initialize
        print "Please enter a name: "
        name = gets.chomp.strip
        @name = name
    end

end