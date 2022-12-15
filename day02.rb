# --- Day 2: Rock Paper Scissors ---

# INPUT: an encrypted guide to several rounds of rock, paper scissors
# There are two columns
# The first column is what your opponent is going to play:
# - A for Rock
# - B for Paper
# - C for Scissors.

# Assume the second column is what you should play in response:
# - X for Rock
# - Y for Paper
# - Z for Scissors
# Winning every time would be suspicious, so the responses must have been carefully chosen.

# The winner of the whole tournament is the player with the highest score.
# Your total score is the sum of your scores for each round plus the score for the outcome of the round
# The score for a single round is the score for the shape you selected:
# - 1 for Rock
# - 2 for Paper
# - 3 for Scissors
# The score for the outcome:
# - 0 if you lost
# - 3 if the round was a draw
# - 6 if you won

# Calculate the score you would get if you were to follow the strategy guide.
# For example, suppose you were given the following strategy guide:

# A Y
# B X
# C Z

# This strategy guide predicts and recommends the following:

# In the first round, your opponent will choose Rock (A), and you should choose Paper (Y).
# This ends in a win for you with a score of 8 (2 because you chose Paper + 6 because you won).
# In the second round, your opponent will choose Paper (B), and you should choose Rock (X).
# This ends in a loss for you with a score of 1 (1 + 0).
# The third round is a draw with both players choosing Scissors, giving you a score of 3 + 3 = 6.

# In this example, if you were to follow the strategy guide, you would get a total score of 15 (8 + 1 + 6).
# What would your total score be if everything goes exactly according to your strategy guide?

opponent_mappings = { 'A': 'Rock', 'B': 'Paper', 'C': 'Scissors' }
shape_scores = { 'Rock': 1, 'Paper': 2, 'Scissors': 3 }
total_score = 0

results = {
  'Rock-Rock': 3,
  'Rock-Paper': 6,
  'Rock-Scissors': 0,
  'Paper-Rock': 0,
  'Paper-Paper': 3,
  'Paper-Scissors': 6,
  'Scissors-Rock': 6,
  'Scissors-Paper': 0,
  'Scissors-Scissors': 3
}

file = File.open('day02_input.txt')

# PART 1: Answer

# my_mappings = { 'X': 'Rock', 'Y': 'Paper', 'Z': 'Scissors' }

# file.each do |line|
#   opp, me = line.split(' ')
#   opp_shape = opponent_mappings[opp.to_sym]
#   my_shape = my_mappings[me.to_sym]

#   result_score = results["#{opp_shape}-#{my_shape}".to_sym]
#   shape_score = shape_scores[my_shape.to_sym]
#   total_score += (result_score + shape_score)
# end

# puts "With second column representing the shape I need to draw, my total score is: #{total_score}"

# Now assume instead that the second column says how the round needs to end:
# - X means you need to lose
# - Y means you need to end the round in a draw
# - Z means you need to win

# The total score is still calculated in the same way, but now you need to figure out what shape to choose so the round ends as indicated.
# What would your total score be if everything goes exactly according to your strategy guide?

# PART 2: Answer

my_mappings = { 'X': 0, 'Y': 3, 'Z': 6 }

file.each do |line|
  opp, res = line.split(' ')
  opp_shape = opponent_mappings[opp.to_sym]
  result_score = my_mappings[res.to_sym]

  results.map do |r|
    _, shape = r[0].to_s.split('-') if r[0].start_with?(opp_shape) && r[1] == result_score
    total_score += (result_score + shape_scores[shape.to_sym]) if shape
  end
end

puts "With second column representing the overall result my total score is: #{total_score}"
