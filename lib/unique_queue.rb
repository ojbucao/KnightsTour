require 'set'

class UniqueQueue
	def initialize
		@queue = []
		@history = Set.new
	end

	def push(arg)
		if !@history.include?(arg) && !@queue.include?(arg)
			@history << arg
		  @queue << arg
		end    
	end

	def items
		@queue
	end

  def shift
  	@queue.shift
  end

  def empty?
  	@queue.empty?
  end
end