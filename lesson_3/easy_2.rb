flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.each do |n|
  if n.start_with?("Be")
    p n
  end
end

p flintstones.map { |f| f[0,2] == "Be"}


p flintstones.index { |name| name[0, 2] == "Be" }

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
p flintstones.map! { |name| name[0,3]}
