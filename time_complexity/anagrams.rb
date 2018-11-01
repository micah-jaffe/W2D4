def first_anagram?(str1, str2)
  char_permutations = str1.chars.permutation.to_a
  char_permutations.map!(&:join)
  char_permutations.include?(str2)
end

def second_anagram?(str1, str2)
  str1.chars.each do |el|
    ind = str2.chars.find_index(el) 
    char_array = str2.chars
    char_array.delete_at(ind) unless ind.nil?
    str2 = char_array.join
  end
  str2 == ''
end

def third_anagram?(str1, str2)
  str1.sort == str2.sort
end

def fourth_anagram?(str1, str2)
  hash1 = Hash.new(0)

  str1.chars.each { |ch| hash1[ch] += 1 }
  str2.chars.each { |ch| hash1[ch] -= 1 }
  hash1.values.all?{|el| el == 0}
end