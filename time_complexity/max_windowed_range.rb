
# O(n^2) time, O(n) space
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
    if @store1.max.nil? && @store2.max.nil?
      nil
    else
      [@store1.max || -Float::INFINTY, @store2.max || -Float::INFINITY].max
    end
  end

  def min
    if @store1.min.nil? && @store2.min.nil?
      nil
    else
      [@store1.min || Float::INFINTY, @store2.min || Float::INFINITY].min
    end
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

# O(n) time, O(n) space
def optimized_windowed_max_range(arr, window_size)
  current_max_range = -1
  window = MinMaxStackQueue.new

  (0...window_size - 1).each { |i| window.enqueue(arr[i]) }

  ((window_size - 1)...arr.length).each do |i|
    window.enqueue(arr[i])
    range = window.max - window.min
    current_max_range = range if range > current_max_range
    window.dequeue
  end

  current_max_range
end

if __FILE__ == $0
  p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  p windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
  p windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
  p windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

  puts "-----------------------------------"

  p optimized_windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  p optimized_windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
  p optimized_windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
  p optimized_windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

end
