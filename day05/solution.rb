file = File.open('input.txt')

@boxes_split_each_char = []
@boxes = []
@directions = []

def parse_file(file)
  file.each do |line|
    if line.chomp.start_with?(' ') || line.chomp.start_with?('[')
      @boxes_split_each_char << line.chomp.chars
    elsif line.chomp.start_with?('move')
      row = []

      line.split(' ').each do |el|
        row.push(el.to_i) if el.to_i.to_s == el
      end

      @directions << row
    end
  end

  clear_whitespace_boxes
end

def move_boxes
  shuffled_boxes = @boxes.clone

  # puts 'boxes:'
  # pp @boxes
  # puts ' '

# @directions.each do |line|
  # puts 'directions: '
  # pp @directions.first
  # puts ' '
  amount, from, to = @directions.first

  from_start_index = 0
  to_start_index = 0
  boxes_to_move = []

  # get the index of the first box in the "from" row
  shuffled_boxes.each do |row|
    break if row[from - 1] != '   ' # empty slots take up three whitespace characters

    from_start_index += 1 
  end

  # get the index of the first box in the "to" row
  shuffled_boxes.each do |row|
    break if row[to - 1] != '   '

    to_start_index += 1
  end

  # select the desired boxes at the start_index of from row [from - 1] until row
  # puts '-' * 50
  # puts ' '
  # puts 'selecting boxes to move'
  # puts ' '

  (0...amount).each do |count|
    row_index = from_start_index + count

    boxes_to_move << shuffled_boxes[row_index][from - 1]
    shuffled_boxes[row_index][from - 1] = '   '
  end

  # puts 'boxes to move: '
  # pp boxes_to_move
  # puts ' '
  # puts '-' * 50
  # puts ' '

  # starting from the top most box, move them to the desired row
  # puts '-' * 50
  # puts ' '
  # puts 'shuffled boxes before moving:'
  pp shuffled_boxes
  puts ' '

  (0...boxes_to_move.size).each do |count|
    puts "to_start_index: #{to_start_index}"
    row_index = to_start_index + count
    puts "row_index: #{row_index}"
    puts "to - 1: #{to - 1}"
    puts "shuffled_boxes[#{row_index}][#{to - 1}]: #{shuffled_boxes[row_index][to - 1]}"
    puts ' '

    shuffled_boxes[row_index][to - 1] = boxes_to_move.shift
  end

  # puts 'boxes to move after moving: '
  # pp boxes_to_move
  # puts ' '

  # puts ' '
  # puts 'shuffled boxes after moving:'
  # pp shuffled_boxes
  # puts ' '
  # end
end

def clear_whitespace_boxes
  @boxes_split_each_char.each do |row|
    new_row = []
    group = []

    row.each_with_index do |char, index|
      if index.zero?
        group << char
      elsif ((index + 1) % 4).zero?
        new_row << group.join
        group = []
      else
        group << char
      end
    end

    new_row << group.join unless group.nil?
    @boxes << new_row
  end
end

parse_file(file)
move_boxes

# pp @boxes_split_each_char
# puts ' '
# puts ' '
# pp @boxes
