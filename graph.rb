require_relative 'node'
require 'set'

class Graph

  def initialize(board:, piece:)
    @board = board
    @piece = piece
    @root = Node.new(location: @piece.start_pos)
    build_graph(@root)
  end

  # build graph starting from root
  def build_graph(root_node)
    completed = Set.new
    queue = [root_node]
    loop do
      current_node = queue.shift
      @piece.current_location = current_node.location
      neighbor_coords = @piece.get_possible_moves
      neighbor_coords.shuffle.each do |n|
        node = find_node(n) || Node.new({location: n})
        current_node.neighbors << node
        queue.push(node) if !queue.include?(node) && !completed.include?(node.location)
      end
      completed << current_node.location
      break if queue.empty?
    end
  end

  # Breadth-First Search
  def bfs(origin=@root, &block)
    queue = [origin]
    visited = Set.new
    until queue.empty? do
      current_node = queue.shift
      visited << current_node
      block.call(current_node) if block_given?
      current_node.neighbors.each do |n|
        queue.push(n) if !visited.include?(n)
      end
    end
    return nil
  end

  def find_node(coords)
    bfs { |node| return node if node.location == coords }
  end

  # Dijkstra's Algorithm
  def find_distances(origin, target=nil)
    distances = {}
    bfs(origin) do |node|
      # we set all nodes that we haven't calculated yet
      # this location, which is an arbitrary high number
      infinity = 999999999
      distances[node] = 0 if distances.empty?
      node.neighbors.each do |neighbor|
        node_dist = distances[node] || infinity
        neighbor_dist = distances[neighbor] || infinity
        # pick the minimum location
        distances[neighbor] = [neighbor_dist, node_dist + 1].min
        if target
          # terminate once we reach the target node
          # calculating the rest of the nodes is not necessary
          return distances if node == target
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
    path = [target.location]
    until current_node == origin
      visited << current_node
      neighbors_sorted = distances.select do |k, v|
                           current_node.neighbors.include?(k)
                         end.sort_by { |n, d| d }
      neighbors_sorted.each do |n, d|
        next if visited.include?(n)
        current_node = n
        break
      end
      path.unshift(current_node.location)
    end
    return path
  end

  # Depth-First Search
  def dfs(origin=@root, &block)
    stack = []
    visited = Set.new
    current_node = args[:start_node] || origin
    until stack.empty?
      previous_node = current_node
      return current_node if current_node.location == args[:target_coords]
      if !stack.include?(current_node) && !visited.include?(current_node)
        stack.push(current_node)
      end
      visited << current_node  if !visited.include?(current_node)
      current_node.neighbors.each do |n|
        current_node = n if !visited.include?(n)
      end
      if current_node == previous_node
        stack.pop
        current_node = stack.last
      end
    end
    return nil
  end

  # Recursive Depth-First Search
  def dfs_recursive(origin, visited)
    return nil if start_node.nil? || start_node.neighbors.empty?
    return nil if visited.include?(origin)
    return start_node if start_node.location == target_coords
    start_node.neighbors.each do |n|
      return dfs_recursive(target_visited)
    end
  end
end