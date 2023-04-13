def create_board
    board = 8.times.map { [0, 1, 2, 3, 4, 5, 6, 7] }
end

def print_board(board)
    board.each_with_index do |row, index|
        puts ''
        print "Row: #{index}:  "
        print row[0].to_s + " | " + row[1..6].join(" | ") + " | " + row[7].to_s
        puts ''
        unless index == 7
            40.times {print "_"}
            puts ''
        end
        
    end
end

#Takes a starting position and an ending position when first called
#Creates a knight object at the starting position, generates a list
#of legal moves that don't go out of bounds and have not already been
#played. Iterating through the list of legal moves, each possible move
#will recursively call the all_paths function using the move as the starting
#position. This will continue until the ending position is reached.
#The history of played moves will be outputted as history.

def all_paths(start, goal, routes = [], history = [])
    if history.length >= 8
        return
    end
    temp_history = []
    history.each do |choice|
        temp_history.push(choice)
    end
    if start == goal
        temp_history.push(start)
        routes.push(temp_history)
        return routes
    end
    current_point = Knight.new(start, goal, temp_history)
    current_point.history.push(start)
    legal_moves = []
    possible_x = [-2, -2, -1, -1, 1, 1, 2, 2].map {|element| element + start[0]}
    possible_y = [-1, 1, -2, 2, -2, 2, -1, 1].map {|element| element + start[1]}
    (0..7).each do |index|
        if ((possible_x[index] in (0..7)) && (possible_y[index] in (0..7)))
            legal_moves.push([possible_x[index], possible_y[index]])
        end
    end
    legal_moves.keep_if {|spot| !(temp_history.include?(spot))}
    return if legal_moves.empty?
    legal_moves.each do |move|
        path = self.all_paths(move, goal, routes, temp_history)
        current_point.possible_paths.push(path)
    end
    return routes
end

#Creates a Knight object that contains a starting position
#the ending spot, a history of all moves played up until now
#and a list of legal moves the knight can take that have not
#already been played

class Knight
    attr_accessor :start, :goal, :history, :possible_paths

    def initialize(start, goal, history = [])
        @start = start
        @goal = goal
        @history = history
        @possible_paths = []
    end
end

#All possible routes from the starting positon to the ending position are generated
#in an array called sorted_paths. This array is sorted from smallest to largest and
#the smallest array is designated as the shortest path from start to end
#All spots in the shortest path will be marked with a full block on a printed chessboard
#then printed. The full path and the number of moves taken is then printed.

board = create_board
choice = all_paths([0,0], [6,2])
sorted_paths = choice.sort {|a, b| a.length <=> b.length}
shortest_path = sorted_paths[0]
shortest_path.each {|step| board[step[0]][step[1]] = '█'}
print_board(board)
puts ''
puts "You made it in #{sorted_paths[0].length - 1} moves! The shortest path is: #{sorted_paths[0]}"

