##
# Several Elves have been assigned the job of cleaning up sections of the camp.
# Every section has a unique ID number, and each Elf is assigned a range of section IDs.

# Some of the Elves have compared their section assignments with each other and noticed that many of the assignments overlap.
# To try to quickly find overlaps and reduce duplicated effort, the Elves pair up and make a big list of the section assignments for each pair (your puzzle input).

# Consider the following list of section assignment pairs:

# 2-4,6-8
# 2-3,4-5
# 5-7,7-9
# 2-8,3-7
# 6-6,4-6
# 2-6,4-8

# For the first few pairs, this list means:
# - Within the first pair of Elves, the first Elf was assigned sections 2-4 (sections 2, 3, and 4), while the second Elf was assigned sections 6-8 (sections 6, 7, 8).
# - The Elves in the second pair were each assigned two sections.
# - The Elves in the third pair were each assigned three sections: one got sections 5, 6, and 7, while the other also got 7, plus 8 and 9.

## PART ONE
#
# Some of the pairs have noticed that one of their assignments fully contains the other.
# For example, 2-8 fully contains 3-7, and 6-6 is fully contained by 4-6.
# In pairs where one assignment fully contains the other, one Elf in the pair would be exclusively cleaning sections their partner will already be cleaning,
# so these seem like the most in need of reconsideration.
# In this example, there are 2 such pairs.
# In how many assignment pairs does one range fully contain the other?

file = File.open('day04_input.txt')
# count_full_cover = 0

## to count where one assignment in a pair fully overlaps the other
# file.each do |pair|
#   e1, e2 = pair.chomp.split(',')

#   e1_start, e1_end = e1.split('-').map(&:to_i)
#   e2_start, e2_end = e2.split('-').map(&:to_i)

#   if (e1_start <= e2_start && e1_end >= e2_end) || (e2_start <= e1_start && e2_end >= e1_end)
#     count_full_cover += 1
#   end
# end

# puts "No. of pairs where one assignment fully covers the other: #{count_full_cover}"

##
# PART TWO

# What is the count where one assignment PARTIALLY overlaps the other?

count_partial_cover = 0

file.each do |pair|
  e1, e2 = pair.chomp.split(',')

  e1_start, e1_end = e1.split('-').map(&:to_i)
  e2_start, e2_end = e2.split('-').map(&:to_i)

  if (e1_end >= e2_start) && (e1_start <= e2_end)
    count_partial_cover += 1
  end
end

puts "No. of pairs with partially overlapping areas: #{count_partial_cover}"
