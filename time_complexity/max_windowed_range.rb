
# Time Complexity: O(n^2)
def windowed_max_range(arr, window_size)
  current_max_range = nil
  arr.each_with_index do |el, i|
    window = arr[i...i+window_size]
    min = window.min
    max = window.max
    range = max - min
    current_max_range = range if current_max_range.nil? || (range > current_max_range)
  end
  current_max_range
end

class MyQueue
  def initialize
    @store = []
  end

  def peek
    @store.first
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end

  def enqueue(el)
    @store.push(el)
    self
  end

  def dequeue
    @store.shift
  end
end


class MyStack
  def initialize
    @store = []
  end

  def peek
    @store.last
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end

  def push(el)
    @store.push(el)
    self
  end

  def pop
    @store.pop
  end

end


class MyStackQueue
  def initialize
    @store1 = MyStack.new
    @store2 = MyStack.new
  end

  def peek
    @store2.peek
  end

  def size
    @store1.count + @store2.count
  end

  def empty?
    @store1.empty? && @store2.empty?
  end

  def enqueue(el)
    @store1.push(el)
    self
  end

  def dequeue
    if @store2.empty?
      @store2.push(@store1.pop) until @store1.empty?
    end

    @store2.pop
  end
end

class MinMaxStack
  def initialize
    @store = MyStack.new
    @max = MyStack.new
    @min = MyStack.new
  end

  def max
    @max.peek
  end

  def min
    @min.peek
  end

  def peek
    @store.peek
  end

  def size
    @store.count
  end

  def empty?
    @store.empty?
  end

  def push(el)
    @max.push(el) if max.nil? || (el > max)
    @min.push(el) if min.nil? || (el < min)

    @store.push(el)
    self
  end

  def pop
    @max.pop if peek == max
    @min.pop if peek == min
    @store.pop
  end

end

class MinMaxStackQueue
  def initialize
    @store1 = MinMaxStack.new
    @store2 = MinMaxStack.new
  end

  def max
    [@store1.max, @store2.max].max
  end

  def min
    [@store1.min, @store2.min].min
  end

  def peek
    @store2.peek
  end

  def size
    @store1.count + @store2.count
  end

  def empty?
    @store1.empty? && @store2.empty?
  end

  def enqueue(el)
    @store1.push(el)
    self
  end

  def dequeue
    if @store2.empty?
      @store2.push(@store1.pop) until @store1.empty?
    end

    @store2.pop
  end
end

if __FILE__ == $0
  # p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  # p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
  # p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
  # p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

  test = MyStackQueue.new
  test.enqueue(1)
  test.enqueue(2)
  test.enqueue(3)
  test.dequeue
  p test.peek

  test2 = MinMaxStack.new
  test2.push(12)
  test2.push(-2)
  test2.push(3)
  test2.push(9)
  p test2.min
  p test2.max
  test2.pop
  test2.pop
  test2.pop
  p test2.min
  p test2.max


  test3 = MinMaxStackQueue.new
  test3.enqueue(5)
  test3.enqueue(1)
  test3.enqueue(-3)
  test3.enqueue(9)
  test3.enqueue(100)

  p test3.min == -3
  p test3.max == 100


end
