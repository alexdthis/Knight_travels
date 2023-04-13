def create_board
    row = []
    board = []
    8.times {|element| row.push(element)}
    8.times {|element| board.push(row)}
    return board
end

def print_board(board)
    board.each do |row|
        print row
        puts ''
    end
end

#lists all possible paths that will lead to our ending goal
#generates all moves possible from our staring spot
#goes through and checks if each move is out-of-bounds or has already been played
#generates a new node in our all_paths tree
#stops when no spots are available to travel to or when the goal is reached

def all_paths(start, goal, history = [])
    if start == goal || history.length >= 10
        return
    end
    temp_history = []
    history.each do |choice|
        temp_history.push(choice)
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
        path = self.all_paths(move, goal, temp_history)
        current_point.possible_paths.push(path)
    end
    return current_point
end

def find_shortest_path(goal, tree)
    return tree.history if tree.start == goal
    tree.possible_paths.each {|path| self.find_shortest_path(goal, path)}
end

class Knight
    attr_accessor :start, :goal, :history, :possible_paths

    def initialize(start, goal, history = [])
        @start = start
        @goal = goal
        @history = history
        @possible_paths = []
    end
end

board = create_board
choice = all_paths([0,0], [2,4])
puts choice.possible_paths
#print choice.history
#puts choice.possible_paths.each {|path| puts path}

