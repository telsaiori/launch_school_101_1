#5

def is_a_number?(word)
  if word.to_i != 0
    true
  else
    false
  end
end

def dot_separated_ip_address?(input_string)
  dot_separated_words = input_string.split(".")
  return false if dot_separated_words.size != 4
  while dot_separated_words.size > 0 do
    word = dot_separated_words.pop
    return false if !is_a_number?(word)
  end
  true
end
dot_separated_ip_address?("1.23.109.5")
dot_separated_ip_address?("1.23.109")
dot_separated_ip_address?("aa")

#4

def uuid
  # 8-4-4-4-12 |
  string1 = 8.times.map { [*0..9, *"a".."z"].sample}.join
  string2 = 4.times.map { [*0..9, *"a".."z"].sample}.join
  string4 = 4.times.map { [*0..9, *"a".."z"].sample}.join
  string5 = 4.times.map { [*0..9, *"a".."z"].sample}.join
  string3 = 12.times.map { [*0..9, *"a".."z"].sample}.join
  puts string1 +"-"+ string2 +"-"+ string4 +"-"+ string5 +"-"+ string3
end

def uuid2
  range = []
  (0..9).each {|digit| range << digit}
  ("a".."z").each { |digit| range << digit}

  uuid = ""
  section = [ 8, 4, 4, 4, 12]
  section.each_with_index do |length, index|
    length.times { uuid += range.sample.to_s }
    uuid += "-" if index < 4
  end
  p uuid
end