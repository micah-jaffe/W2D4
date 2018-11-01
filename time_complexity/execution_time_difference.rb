def my_min_phase1(arr)
  min_el = arr.first
  arr.each_with_index do |el1, i|
    arr[i+1..-1].each do |el2|
      min_el = el1 if el1 < el2
    end
  end
  min_el
end

def my_min_phase2(arr)
  min_el = arr.first
  arr.each do |el|
    min_el = el if el < min_el
  end
  min_el
end

def largest_contiguous_subsum1(list)
  sub_arrays = []
  list.each_with_index do |el1, i|
    list[i+1..-1].each do |el2|
      sub_arrays << [el1, el2]
    end
  end
  
  sub_arrays.max_by {|el| el.reduce(:+)}.reduce(:+)
  
end

def largest_contiguous_subsum2(list)
    largest_sum = 0
    largest_this_block = 0
    list.each do |el|
      largest_this_block += el
      largest_this_block = 0 if largest_this_block < 0      
      largest_sum = largest_this_block if largest_this_block > largest_sum
    end
    largest_sum
end