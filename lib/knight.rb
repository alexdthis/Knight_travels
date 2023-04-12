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