# Knight_travels

This program will calculate the shortest possible path to get a knight from
a given starting position to a specified position.

The input will be represented by two arrays [x,y] and [a, b] where x, y, a, and b
are the x and y coordinates of the chessboard.

The chess board will be represented as a 2-D array with n rows represented by n arrays
with m columns representing the cells of each row. [1, 1] x [8,8]

Each possible path a knight can take will be represented by a (not necessarily binary) tree.

Each node will be the spot a knight takes by either subtracting or adding two from the x
or y coordinate followed by subtracting or adding one from the opposite coordinate. If
the range is out of bounds, the move is illegal and will not be added to the tree.

After a tree of the possible moves is made, a search method will be employed (to be decided)
in order to find all paths that will reach the chosen point.

These paths will then be filtered so that the path with the least number of moves will be
outputted to the user.



Program flow:

Construct an 8x8 chessboard by using a loop to make a 8 rows containing 8 numbers each. This
will have a Board class.

Construct a Knight object that will accept a position, have a current position, and 
will have a method that be used to construct the tree. It will have the following methods:

- knight_moves - this will take a starting position [x,y] and an ending position [a,b]. This will
output all the coordinates taken in order to reach the ending position. It will call the
possible_moves method in order to construct a tree to find the shortest path to its destination.

Afterwards, a search method will be called in order to find all paths that will lead the knight to the ending position. There are two ways to go about finding the shortest route:

1. Use a breadth first search to comb through every level. The first path to match will be the shortest
2. Store all paths in an array, and sort them. The shortest path will be in the array.

After the shortest path is found, it will be outputted to the user.
