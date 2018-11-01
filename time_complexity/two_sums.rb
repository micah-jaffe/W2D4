# Time Complexity: O(n^2)
# Space Complexity: Linear
def bad_two_sum?(arr, target)
  arr.each_with_index do |el1, i|
    arr[i+1..-1].each do |el2|
      return true if el1 + el2 == 0
    end
  end
  return false
end

# Time Complexity: O(nlogn)
# Space Complexity: O(n)
def okay_two_sum?(arr, target)
  sorted_arr = arr.sort
  mid_left = arr.length / 2 - 1
  mid_right = arr.length / 2
  
  until arr[mid_left].nil? || arr[mid_right].nil?
    return true if arr[mid_left] + arr[mid_right] == target
    if arr[mid_left] + arr[mid_right] > target
      mid_left -= 1
    else
      mid_right += 1
    end
  end
  false
end

# Time Complexity: O(n)
# Space Complexity: O(n)
def good_two_sum?(arr, target)
  hash = {}
  arr.each do |el|
    return true if hash.has_key?(target-el)
    hash[el] = true
  end
  false
end