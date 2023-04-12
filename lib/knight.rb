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

board = create_board
print_board(board)

#lists all possible paths that will lead to our ending goal
#generates all moves possible from our staring spot
#goes through and checks if each move is out-of-bounds or has already been played
#generates a new node in our all_paths tree
#stops when no spots are available to travel to or when the goal is reached

def all_paths(start, goal, board = create_board, history = [])
    if start == goal
        return
    end
    current_point = Move.new(start, goal, board, history)
    x_coord = start[0]
    y_coord = start[1]
    legal_moves = []
    possible_x = [-2, -2, -1, -1, 1, 1, 2, 2].map {|element| element + x_coord}
    possible_y = [-1, 1, -2, 2, -2, 2, -1, 1].map {|element| element + y_coord}
    (0..7).each do |index|
        if ((possible_x[index] in (0..7)) && (possible_y[index] in (0..7)))
            legal_moves.push([possible_x[index], possible_y[index]])
        end
    end
    legal_moves.keep_if {|spot| (board[spot[0]][spot[1]] != 'P') && !(history.include?(spot))}
    return if legal_moves.empty?
    legal_moves.each do |move|
        board[move[0]][move[1]] = 'P'
        history.push(move)
        path = self.all_paths(move, goal, board, history)
        current_point.history.push(history)
        current_point.possible_paths.push(path)
    end
    return current_point
end

class Move
    attr_accessor :start, :goal, :history, :possible_paths

    def initialize(start, goal, board = create_board, history = [])
        @start = start
        @goal = goal
        @board = board
        @history = history
        @possible_paths = []
    end
end

choice = all_paths([0,0], [2,4])
puts choice.possible_paths
print choice.history
puts choice.possible_paths.each {|path| puts path}

