require 'set'

class UniqueStack
  def initialize
    @stack = []
    @history = Set.new
  end

  def push(arg)
    if !@history.include?(arg) && !@stack.include?(arg)
      @history << arg
      @stack << arg
    end    
  end

  def items
    @stack
  end

  def pop
    @stack.pop
  end

  def empty?
    @stack.empty?
  end
end