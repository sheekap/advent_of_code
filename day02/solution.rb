@opponent_mappings = { 'A': 'Rock', 'B': 'Paper', 'C': 'Scissors' }
@shape_scores = { 'Rock': 1, 'Paper': 2, 'Scissors': 3 }

@results = {
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

file_path = File.join(File.dirname(__FILE__), 'input.txt')
@file = File.open(file_path)

def calculate_score_shape
  my_mappings = { 'X': 'Rock', 'Y': 'Paper', 'Z': 'Scissors' }
  total_score = 0

  @file.each do |line|
    opp, me = line.split(' ')
    opp_shape = @opponent_mappings[opp.to_sym]
    my_shape = my_mappings[me.to_sym]

    result_score = @results["#{opp_shape}-#{my_shape}".to_sym]
    shape_score = @shape_scores[my_shape.to_sym]
    total_score += (result_score + shape_score)
  end

  total_score
end

def calculate_score_result
  my_mappings = { 'X': 0, 'Y': 3, 'Z': 6 }
  total_score = 0

  @file.each do |line|
    opp, res = line.split(' ')
    opp_shape = @opponent_mappings[opp.to_sym]
    result_score = my_mappings[res.to_sym]

    @results.map do |r|
      _, shape = r[0].to_s.split('-') if r[0].start_with?(opp_shape) && r[1] == result_score
      total_score += (result_score + @shape_scores[shape.to_sym]) if shape
    end
  end

  total_score
end

# puts "With second column representing the shape I need to draw, my total score is: #{calculate_score_shape}"
puts "With second column representing the overall result my total score is: #{calculate_score_result}"
