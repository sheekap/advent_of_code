input_file = File.join(File.dirname(__FILE__), 'input.txt')
list = File.open(input_file)

summed = []
elf_total = 0

list.each do |calories|
  if calories.chomp.empty?
    summed << elf_total
    elf_total = 0
  else
    elf_total += calories.chomp.to_i
  end
end

summed.sort!

## PART ONE: Answer

puts "The elf with the highest calories count is carrying: #{summed.last} calories"

# Find the top three Elves carrying the most Calories. How many Calories are those Elves carrying in total?
## PART TWO: Answer

puts "The three Elves carrying the most calories have a combined count of: #{summed.last(3).reduce(:+)} calories"
