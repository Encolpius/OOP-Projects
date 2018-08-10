class Board 

    require_relative 'game.rb'

    $grid = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

    def create_board
        $grid.each_slice(3) do |grid_slice|
            grid_slice[0..1].each do |el|
                 print el + " | "
            end 
            print grid_slice[2]
            puts
            puts "-- --- ---"
        end
    end

end