require 'spec_helper'
require_relative '../lib/unique_stack'

describe 'UniqueStack' do
	it 'can be instantiated' do
		stack = UniqueStack.new
	end

  it 'can stack new items on the top' do
  	stack = UniqueStack.new
  	expect(stack.push(1)).to eq([1])
  end

  it 'lists the items' do
  	stack = UniqueStack.new
  	stack.push(1)
  	expect(stack.items).to eq([1])

  	stack.push(2)
  	expect(stack.items).to eq([1, 2])
  end

  it 'only keeps one of the same item' do
  	stack = UniqueStack.new
  	stack.push(1)
  	stack.push(1)
  	expect(stack.items).to eq([1])
  end

  it 'can pop items from the top' do
  	stack = UniqueStack.new
  	stack.push(1)
  	stack.push(2)
  	expect(stack.pop).to eq(2)
  	expect(stack.items).to eq([1])
  end


  it 'only takes an item if the item has never been pushed before' do
    stack = UniqueStack.new
    stack.push(1)
    stack.push(2)
    stack.pop
    stack.push(1)
    expect(stack.items).to eq([1])
  end

  describe '#empty?' do
  	it 'returns true if empty, false if not' do
  		stack = UniqueStack.new
      expect(stack).to be_empty
  	end
  end


end