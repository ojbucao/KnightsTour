require_relative 'unique_queue'
require_relative 'unique_stack'
require_relative 'node'
require 'digest'
require 'set'

class Graph

  attr_reader :node_count

  def initialize(board:, piece:)
    @board = board
    @piece = piece
    @root = Node.new(location: @piece.start_pos)

    @node_count = build_graph(@root)
  end

  def tour
    current_node = @root
    current_location = current_node.location

    path = []
    path << current_node.location

    failed_paths = []

    until path.count == @node_count

      current_node_cache = current_node

      # Remove visited neighbors then rioitize the neighbor node that has 
      # the least amount of its own neighbors. This makes the algorithm a lot faster

      trimmed_neighbors = current_node.neighbors.reject { |n| path.include? n.location }
      sorted_neighbors = trimmed_neighbors.sort_by {|n| n.neighbors.count { |x| !path.include? x } }

      sorted_neighbors.each do |node|
        potential_path = path + Array[node.location]
        potential_path_hashed = get_hash(potential_path)

        # Go to this node if the potential path is not a known bad one or if the next node
        # has not been visited yet. Otherwise, skip it

        if !failed_paths.include?(potential_path_hashed) && !path.include?(node.location)
          current_node = node
          break
        end

        next
      end
      
      # There is nowhere to go from current node so we backtrack

      if current_node_cache == current_node
        sleep 1
        failed_paths << get_hash(path)
        path.pop
        current_node = find_node(path.last)
      else
        path << current_node.location
      end

      yield(path) if block_given?

      if failed_paths.count > 1000
        raise 'Search terminated. Taking too long to find a path.'
      end
    end

    return { path: path, failed_paths: failed_paths }
  end

  def find_node(coords)
    bfs { |node| return node if node.location == coords }
  end

  def find_shortest_path(origin:, target:)
    origin = find_node(origin) if origin.is_a? Array
    target = find_node(target) if target.is_a? Array

    distances = find_distances(origin: origin, target: target)
    current_node = target
    visited = Set.new
    path = [target.location] # we start at target and backtrack to origin

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

  private

  def get_hash(path_array)
    Digest::MD5.hexdigest(path_array.to_s)[0..6]
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

      completed << @piece.current_location

      break if queue.empty?
    end

    return completed.count
  end

  # Dijkstra's Algorithm
  def find_distances(origin:, target:)
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

        # terminate once we reach the target node because
        # calculating the rest of the nodes is not necessary
          
        if target
          return distances if node == target
        end
      end
    end

    return distances
  end

  # Breadth-First Search
  def bfs(origin = @root, &block)
    uniq_queue = UniqueQueue.new
    uniq_queue.push(origin)

    until uniq_queue.empty? do
      current_node = uniq_queue.shift

      block.call(current_node) if block_given?

      current_node.neighbors.each do |n|
        uniq_queue.push(n)
      end
    end

    return nil
  end

   # Depth-First Search
  def dfs(origin=@root, &block)
    stack = UniqueStack.new
    stack.push(origin)

    until stack.empty? do
      current_node = stack.pop

      block.call(current_node) if block_given?

      current_node.neighbors.each do |n|
        stack.push(n)
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
