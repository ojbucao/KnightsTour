# Knight's Tour Problem
# Calculate the shortest path for the Knight
# between two squares on the chess board

class Board
  @@KnightMovements = [[-2,-1],[-2,1],[-1,-2],[-1,2],[1,-2],[1,2],[2,-1],[2,1]]
  attr_accessor :locations

  def initialize(size)
    @locations = size.times.map do |n|
                   size.times.map { |m| [n,m] }
                 end.flatten(1)
  end

  def include?(square)
    squares.include? square
  end

  # neighbors are all possible moves available from a node
  def generate_neighbor_coords(coords)
    all_possible = @@KnightMovements.map do |move|
                     [coords[0] + move[0], coords[1] + move[1]]
                   end
    in_board = all_possible.select do |move|
                 @locations.include?(move)
               end
  end
end


class Node
  attr_accessor :value, :neighbors

  def initialize(arg)
    @value = arg[:value]
    @neighbors = []
  end
end


class KnightsGraph
  attr_accessor :root

  def initialize(coords, board)
    @board = board
    @root = Node.new(value: coords)
    build_graph(@root)
  end

  # build graph starting from root
  def build_graph(root_node)
    created_nodes = [root_node]
    queue = [root_node]
    loop do
      current_node = queue.pop
      neighbor_coords = @board.generate_neighbor_coords(current_node.value)
      neighbor_coords.shuffle.each do |n|
        node = bfs(target_coords: n) || node = Node.new({value: n})
        current_node.neighbors << node
        queue.unshift(node) if !created_nodes.include?(node.value)
        queue.uniq!
      end
      created_nodes << current_node.value
      break if queue.empty?
    end
  end

  # Breadth-First-Search with shortest distance checking
  # The strategy used is to pick the next neighbor 
  # that is closest to the target node and so forth. 
  def bfs_shortest(args)
    queue = [args[:start_node] || @root]
    visited = []
    loop do
      visited << current_node = queue.pop
      args[:path] << current_node.value if args[:path]
      return current_node if current_node.value == args[:target_coords]
      node_distances_hash = Hash.new
      current_node.neighbors.each do |n|
        distance = calculate_distance(args[:target_coords],n.value)
        node_distances_hash[distance] = n
      end
      node_distances_hash.sort.each do |d,n|
        next if visited.include?(n)
        queue.unshift(n)
        break
      end
      break if calculate_distance(args[:target_coords],current_node.value) == 0
    end
    return nil
  end

  def calculate_distance(target_coords, start_coords)
    # Use Pythagorean Theorem for calculating the distance between 2 points
    x = target_coords[0] - start_coords[0]
    y = target_coords[1] - start_coords[1]
    Math.sqrt((x ** 2) + (y ** 2))
  end

  # Breadth-First-Search regular
  def bfs(args)
    queue = [args[:start_node] || @root]
    visited = []
    loop do
      visited << current_node = queue.pop
      args[:path] << current_node.value if args[:path]
      return current_node if current_node.value == args[:target_coords]
      current_node.neighbors.each do |n|
        queue.unshift(n) if !visited.include?(n)
      end
      break if queue.empty?
    end
    return nil
  end

  # This does not work. It results in an infinite-regression
  # because the data structure is not a tree, but a graph with no end points
  # I'm leaving this here just for curiosity.
  def dfs_recursive(target_coords, start_node)
    return nil if start_node.nil? || start_node.neighbors.empty?
    return start_node if start_node.value == target_coords
    start_node.neighbors.each do |n|
      return dfs_recursive(target_coords, n)
    end
  end

  # Depth-First-Search
  def dfs(args)
    stack = []
    visited = []
    current_node = args[:start_node] || @root
    loop do
      previous_node = current_node
      args[:path] << current_node.value if args[:path]
      return current_node if current_node.value == args[:target_coords]
      stack.push(current_node) if !visited.include?(current_node)
      stack.uniq!
      visited << current_node  if !visited.include?(current_node)
      current_node.neighbors.each do |n|
        current_node = n if !visited.include?(n)
      end
      if current_node == previous_node
        stack.pop
        break if stack.empty?
        current_node = stack[-1]
      end
    end
    return nil
  end
end


def knight_moves(start_coords, target_coords)
  board = Board.new(8)
  paths = []

  # Run 10 times and then pick the shortest path
  10.times do
    graph = KnightsGraph.new([0,0],board)
    path = []
    params = { target_coords: target_coords,
                  start_node: graph.bfs(target_coords: start_coords),
                        path: path }
    graph.bfs_shortest(params)
    paths.push(path)
  end

  paths.sort_by! { |x| x.length }
  path = paths[0]

  p "Knight moves from #{start_coords} to #{target_coords}."
  p "You made it in #{path.size - 1} moves! Here's your path: "
  puts path.inspect
end



knight_moves([3,3],[4,4])

# "Knight moves from [3, 3] to [4, 4]."
# "You made it in 4 moves! Here's your path: "
# [[3, 3], [4, 5], [2, 4], [3, 2], [4, 4]]
