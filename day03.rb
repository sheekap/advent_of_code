# Each elf rucksack has two large compartments. 
# All items of a given type are meant to go into exactly one of the two compartments. 
# The Elf that did the packing failed to follow this rule for exactly one item type per rucksack.

# The Elves have made a list of all of the items currently in each rucksack (your puzzle input), but they need your help finding the errors.
# Every item type is identified by a single lowercase or uppercase letter (that is, a and A refer to different types of items).

# The list of items for each rucksack is given as characters all on a single line.
# A given rucksack always has the same number of items in each of its two compartments, 
# so the first half of the characters represent items in the first compartment, 
# while the second half of the characters represent items in the second compartment.

# For example, suppose you have the following list of contents from six rucksacks:

# vJrwpWtwJgWrhcsFMMfFFhFp
# jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
# PmmdzqPrVvPwwTWBwg
# wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
# ttgJtRGJQctTZtZT
# CrZsJsPPZsGzwwsLwLmpwMDw

# - The first rucksack contains the items vJrwpWtwJgWrhcsFMMfFFhFp, which means its first compartment contains the items vJrwpWtwJgWr,
# while the second compartment contains the items hcsFMMfFFhFp. The only item type that appears in both compartments is lowercase p.
# - The second rucksack's compartments contain jqHRNqRjqzjGDLGL and rsFMfFZSrLrFZsSL. The only item type that appears in both compartments is uppercase L.
# - The third rucksack's compartments contain PmmdzqPrV and vPwwTWBwg; the only common item type is uppercase P.
# - The fourth rucksack's compartments only share item type v.
# - The fifth rucksack's compartments only share item type t.
# - The sixth rucksack's compartments only share item type s.

# To help prioritize item rearrangement, every item type can be converted to a priority:

# - Lowercase item types a through z have priorities 1 through 26.
# - Uppercase item types A through Z have priorities 27 through 52.

##
# PART ONE

# In the above example, the priority of the item type that appears in both compartments of each rucksack is 16 (p), 38 (L), 42 (P), 22 (v), 20 (t), and 19 (s);
# the sum of these is 157.

# Find the item type that appears in both compartments of each rucksack. What is the sum of the priorities of those item types?

priorities = {
  a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13,
  n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, w: 23, x: 24, y: 25, z: 26,
  A: 27, B: 28, C: 29, D: 30, E: 31, F: 32, G: 33, H: 34, I: 35, J: 36, K: 37, L: 38, M: 39,
  N: 40, O: 41, P: 42, Q: 43, R: 44, S: 45, T: 46, U: 47, V: 48, W: 49, X: 50, Y: 51, Z: 52 
}

# sum_individual = 0

file = File.open('day03_input.txt')

# file.each do |line|
#   common_items = []

#   items = line.chars
#   first_comp = items.slice(0, (items.length / 2))
#   second_comp = items.slice((items.length / 2), items.length)

#   first_comp.each { |item| common_items << item if second_comp.include?(item) }

#   common_items = common_items.uniq

#   if common_items.size != 1
#     puts "Houston, we have a problem. Common items: #{common_items}, line: #{line}"
#   else
#     sum += priorities[common_items.first.to_sym]
#   end
# end

# puts "Sum of priorities for all common items: #{sum_individual}"

##
# PART TWO

# Every set of three lines in your list corresponds to a single group, but each group can have a different badge item type,
# where a badge represents the item that is common to each elf in the group.
# So, in the above example, the first group's rucksacks are the first three lines:

# vJrwpWtwJgWrhcsFMMfFFhFp
# jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
# PmmdzqPrVvPwwTWBwg

# And the second group's rucksacks are the next three lines:

# wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
# ttgJtRGJQctTZtZT
# CrZsJsPPZsGzwwsLwLmpwMDw

# In the first group, the only item type that appears in all three rucksacks is lowercase r; this must be their badges.
# In the second group, their badge item type must be Z.

# Priorities for these items must still be found to organize the sticker attachment efforts: 
# here, they are 18 (r) for the first group and 52 (Z) for the second group.
# The sum of these is 70.

# Find the item type that corresponds to the badges of each three-Elf group.
# What is the sum of the priorities of those item types?

sum_group = 0

file.each_slice(3) do |group|
  first, second, third = group.sort_by(&:length)
  common_items = []

  first.chomp.each_char do |item|
    common_items << item if second.chomp.include?(item) && third.chomp.include?(item)
  end

  common_items = common_items.uniq
  sum_group += priorities[common_items.first.to_sym]
end

puts "Sum of priorities for common item per groups of three: #{sum_group}"
