# --- Day 1: Calorie Counting ---

# Input: the series of integers representing the number of calories for each snack an elf is carrying
# Each Elf separates their own inventory from the previous Elf's inventory (if any) by a blank line.

# For example, suppose the Elves finish writing their items' calories and end up with the following list:

# 1000
# 2000
# 3000

# 4000

# 5000
# 6000

# 7000
# 8000
# 9000

# 10000

# This list represents the Calories of the food carried by five Elves:

#     The first Elf is carrying food with 1000, 2000, and 3000 Calories, a total of 6000 Calories.
#     The second Elf is carrying one food item with 4000 Calories.
#     The third Elf is carrying food with 5000 and 6000 Calories, a total of 11000 Calories.
#     The fourth Elf is carrying food with 7000, 8000, and 9000 Calories, a total of 24000 Calories.
#     The fifth Elf is carrying one food item with 10000 Calories.

# Find the Elf carrying the most Calories (in the example above it is the 4th Elf with 24000 calories).
# How many total Calories is that Elf carrying?

list = File.open('day01_input.txt')
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
