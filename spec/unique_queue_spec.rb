require 'spec_helper'
require_relative '../lib/unique_queue'

# TODO: refactor and clean this up

describe 'UniqueQueue' do
	it 'can be instantiated' do
		queue = UniqueQueue.new
	end

  it 'can queue new items on the top' do
  	queue = UniqueQueue.new
  	expect(queue.push(1)).to eq([1])
  end

  it 'lists the items' do
  	queue = UniqueQueue.new
  	queue.push(1)
  	expect(queue.items).to eq([1])

  	queue.push(2)
  	expect(queue.items).to eq([1, 2])
  end

  it 'only keeps one of the same item' do
  	queue = UniqueQueue.new
  	queue.push(1)
  	queue.push(1)
  	expect(queue.items).to eq([1])
  end

  it 'can dequeue items from the bottom' do
  	queue = UniqueQueue.new
  	queue.push(1)
  	queue.push(2)
  	expect(queue.shift).to eq(1)
  	expect(queue.items).to eq([2])
  end


  it 'only takes an item if the item has never been pushed before' do
    queue = UniqueQueue.new
    queue.push(1)
    queue.push(2)
    queue.shift
    queue.push(1)
    expect(queue.items).to eq([2])
  end

  describe '#empty?' do
  	it 'returns true if empty, false if not' do
  		queue = UniqueQueue.new
      expect(queue).to be_empty
  	end
  end


end