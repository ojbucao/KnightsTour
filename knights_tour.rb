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


require 'set'

class KnightsGraph
  attr_accessor :root

  def initialize(coords, board)
    @board = board
    @root = Node.new(value: coords)
    build_graph(@root)
  end

  # build graph starting from root
  def build_graph(root_node)
    completed = Set.new
    queue = [root_node]
    loop do
      current_node = queue.shift
      neighbor_coords = @board.generate_neighbor_coords(current_node.value)
      neighbor_coords.shuffle.each do |n|
        node = find_node(n) || node = Node.new({value: n})
        current_node.neighbors << node
        queue.push(node) unless queue.include?(node) && !completed.include?(node.value)
      end
      completed << current_node.value
      break if queue.empty?
    end
  end

  def bfs(origin=@root, &block)
    queue = [origin]
    visited = Set.new
    until queue.empty? do
      current_node = queue.shift
      visited << current_node
      block.call(current_node) if block_given?
      current_node.neighbors.each do |n|
        queue.push(n) unless visited.include?(n)
      end
    end
    return nil
  end

  def find_node(coords)
    bfs { |vertex| return vertex if vertex.value == coords }
  end

  # Dijkstra's Algorithm
  def find_distances(origin, target=nil)
    distances = {}
    bfs(origin) do |vertex|
      # we set all nodes that we haven't calculated yet
      # this value, which is an arbitrary high number
      infinity = 999999999
      distances[vertex] = 0 if distances.empty?
      vertex.neighbors.each do |neighbor|
        vertex_dist = distances[vertex] || infinity
        neighbor_dist = distances[neighbor] || infinity
        # pick the minimum value
        distances[neighbor] = [neighbor_dist, vertex_dist + 1].min
        if target
          # terminate once we reach the target node
          # calculating the rest of the nodes is not necessary
          return distances if vertex == target
        end
      end
    end
    return distances
  end

  def find_shortest_path(origin, target)
    distances = find_distances(origin, target)
    current_node = target
    visited = Set.new
    # we start at target and backtrack to origin
    path = [target.value]
    until current_node == origin
      visited << current_node
      neighbors_sorted = distances.select do |k,v|
                           current_node.neighbors.include?(k)
                         end.sort_by { |n,d| d }
      neighbors_sorted.each do |n,d|
        next if visited.include?(n)
        current_node = n
        break
      end
      path.unshift(current_node.value)
    end
    return path
  end

  # Depth-First-Search
  def dfs(origin=@root, &block)
    stack = []
    visited = Set.new
    current_node = args[:start_node] || origin
    until stack.empty?
      previous_node = current_node
      return current_node if current_node.value == args[:target_coords]
      unless stack.include?(current_node) && !visited.include?(current_node)
        stack.push(current_node)
      end
      visited << current_node  unless visited.include?(current_node)
      current_node.neighbors.each do |n|
        current_node = n unless visited.include?(n)
      end
      if current_node == previous_node
        stack.pop
        current_node = stack.last
      end
    end
    return nil
  end

  def dfs_recursive(origin, visited)
    return nil if start_node.nil? || start_node.neighbors.empty?
    return nil if visited.include?(origin)
    return start_node if start_node.value == target_coords
    start_node.neighbors.each do |n|
      return dfs_recursive(target_visited)
    end
  end
end


def knight_moves(start_coords, target_coords)
  board = Board.new(8)
  graph = KnightsGraph.new([0,0], board)

  origin_node = graph.find_node(start_coords)
  target_node = graph.find_node(target_coords)

  path = graph.find_shortest_path(origin_node, target_node)

  puts "\nKnight moves from #{start_coords} to #{target_coords}."
  puts "You made it in #{path.size - 1} moves!"
  puts "Here's your path: "
  path.each { |p| puts "#{p.inspect}" }
  puts
end


knight_moves([0,0],[7,7])

# Knight moves from [0, 0] to [7, 7].
# You made it in 6 moves!
# Here's your path:
# [0, 0]
# [2, 1]
# [3, 3]
# [5, 2]
# [6, 4]
# [5, 6]
# [7, 7]
