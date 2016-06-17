require 'spec_helper'
require_relative '../lib/board'
require_relative '../lib/graph'
require_relative '../lib/knight'

describe 'Graph' do
	let!(:size) { 8 }
	let!(:board) { Board.new(size: size) }
	let!(:piece) { Knight.new(board: board) }
	let!(:graph) { Graph.new(board: board, piece: piece) }

	describe '#initialize' do
		it 'takes a board and a piece' do
			expect(graph).not_to be_nil
		end
	end

  describe 'public methods' do
  	describe '#node_count' do
  		it 'returns the number of nodes' do
  			expect(graph.node_count).to eq(size ** 2)
  		end
  	end

		describe '#find_node' do
			it 'finds a node object for a given set of coordinates' do
				location = [3,4]
				node = graph.find_node(location)
				expect(node).not_to be_nil
				expect(node.location).to eq(location)
				expect(node.neighbors.count).to be > 0
			end
		end

		describe '#find_shortest_path' do
			context 'when given a set of coordinates' do
				it 'finds the shortest path between them' do
					origin = [0,0]
					target = [7,7]
					path = graph.find_shortest_path(origin: origin, target: target)

					expect(path).to be_an(Array)
					expect(path.first).to eq(origin)
					expect(path.last).to eq(target)
					expect(path.count).to eq(7)
				end	
			end

			context 'when given a set of nodes' do
				it 'finds the shortest path between them' do
					origin = graph.find_node([0,0])
					target = graph.find_node([7,7])
					path = graph.find_shortest_path(origin: origin, target: target)

					expect(path).to be_an(Array)
					expect(path.first).to eq(origin.location)
					expect(path.last).to eq(target.location)
					expect(path.count).to eq(7)
				end	
			end
	  end
	end

  describe 'private methods' do
	 	describe '#find_distances' do
	 		context 'when given 2 nodes, origin and target' do
	 			it 'returns a hash of all nodes and their distances from origin' do
					origin = graph.find_node([0,0])
					target = graph.find_node([7,7])

					distances = graph.send(:find_distances, { origin: origin, target: target } )

					expect(distances).to be_a Hash
					expect(distances.count).to eq(size ** 2)
					expect(distances.keys.first).to be_a Node
					expect(distances.values.first).to eq(0)
					expect(distances.values.last).to eq(6)
	 			end
	 		end
		end

	  describe '#bfs' do
	  	it 'goes through all the nodes' do
	  		b = Board.new(size: 8)
	  		k = Knight.new(board: b)
	  		graph = Graph.new(board: b, piece: k)
	  		nodes_touched = 0
	  		graph.send(:bfs) { |node| nodes_touched += 1; }

	  		expect(nodes_touched).to eq(size ** 2)
	  	end
	  end

	  describe '#dfs' do
	  	it 'goes through all the nodes' do
	  		b = Board.new(size: 8)
	  		k = Knight.new(board: b)
	  		graph = Graph.new(board: b, piece: k)
	  		nodes_touched = 0
	  		graph.send(:bfs) { |node| nodes_touched += 1; }

	  		expect(nodes_touched).to eq(size ** 2)
	  	end
	  end

	  describe '#dfs_recursive' do
	  end
	end
end