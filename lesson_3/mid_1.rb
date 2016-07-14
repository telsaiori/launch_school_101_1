#9
munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# age_group kid is in the age range 0 - 17, 
# an adult is in the range 18 - 64 and a 
# senior is aged 65+.
munsters.each do |munster|
  age = munster[1]["age"]
  case age
    when 0..17
      munster[1]["age_group"] = "kid"
    when 18..64
      munster[1]["age_group"] = "adult"
    else
      munster[1]["age_group"] = "senior"
  end
end
p munsters

munsters.each do |name, details|
  case details["age"]
  when 0...18
    details["age_group"] = "kid"
  when 18...65
    details["age_group"] = "adult"
  else
    details["age_group"] = "senior"
  end
end

#8
test = " I am a girl "
temp = ""
test.split(" ").map! do |p|
  p.capitalize!
  temp << " #{p}"
end
p temp

test = " i am a boy"
test.split(' ').map { |e| e.capitalize! }.join(' ')

#7
limit = 15

def fib(first_num, second_num, limit)
  while second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, limit)
puts "result is #{result}"




statement = "The Flintstones Rock"
count = {}
statement.split('').each do |letter|
  if letter != ' '
    count[letter] = statement.count(letter)
  end
end
p count


result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end

p result