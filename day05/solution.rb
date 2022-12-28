# Class to hold methods for day 5 of Advent of Code 2022
class SupplyStacks
  def initialize(filename)
    input = File.join(File.dirname(__FILE__), filename)
    file = File.open(input)

    @boxes_split_each_char = []
    @boxes = []
    @directions = []

    parse_file(file)
  end

  def move_boxes
    @directions.each do |line|
      amount, from, to = line

      from_start_index = 0
      to_start_index = -1 # TODO: double check conditional when calculcating this index
      boxes_to_move = []

      # get the index of the first box in the "from" row
      @boxes.each do |row|
        break if row[from - 1] != '   ' # empty slots take up three whitespace characters

        from_start_index += 1 
      end

      # get the index of the first box in the "to" row
      @boxes.each do |row|
        break if row[to - 1] != '   '

        to_start_index += 1
      end

      # select the desired `amount` boxes starting at the start_index of row = [calculcate_desired_row_index] column = from - 1 
      (0...amount).each do |count|
        row_index = from_start_index + count

        boxes_to_move << @boxes[row_index][from - 1]
        @boxes[row_index][from - 1] = '   '
      end

      (0...boxes_to_move.size).each do |count|
        row_index = (to_start_index - count)

        if row_index.positive? || row_index.zero?
          @boxes[row_index][to - 1] = boxes_to_move.shift
        else
          create_new_row_for_box(boxes_to_move.shift, (to - 1), @boxes.last.size)
        end
      end
    end
  end

  def print_top_boxes
    @boxes.pop # delete last row that is just the column counts

    result = Array.new(@boxes.first.size)

    @boxes.each do |row|
      row.each_with_index do |val, index|
        next unless result[index].nil?

        result[index] = val.tr('[', '').tr(']', '') if val != '   '
      end
    end

    result = result.join
  end

  private

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

  def create_new_row_for_box(box, index, length)
    new_row = []

    (0...length).each do |i|
      if i == index
        new_row << box
      else
        new_row << '   '
      end
    end

    @boxes.unshift(new_row)
  end
end
