class Players

    @@players = 1
    attr_reader :grid_placement, :name, :choices

    def initialize
        print "Player #{@@players}, please enter a name: "
        name = gets.chomp.strip
        @name = name
        @choices = []
        @@players == 1 ? @grid_placement = "X" : @grid_placement = "O"
        @@players += 1
    end

end