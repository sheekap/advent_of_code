# Class to hold methods for day 5 of Advent of Code 2022
class SupplyStacks
  def initialize(filename)
    input = File.join(File.dirname(__FILE__), filename)
    file = File.open(input)

    @boxes_split_each_char = []
    @boxes = []
    @directions = []

    parse_file(file)
    clear_whitespace_between_columns
  end

  def move_boxes(move_multiple: false)
    @directions.each do |line|
      amount, from, to = line

      from_start_index = from_column_start_index(from)
      to_start_index = to_column_start_index(to)
      boxes_to_move = select_boxes_to_move(amount, from, from_start_index)

      move_boxes_to_desired_column(boxes_to_move, to, to_start_index, move_multiple)
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
      if box_row?(line)
        @boxes_split_each_char << line.chomp.chars
      elsif direction_row?(line)
        row = []

        line.split(' ').each do |el|
          row.push(el.to_i) if el.to_i.to_s == el
        end

        @directions << row
      end
    end
  end

  def box_row?(line)
    line.chomp.start_with?(' ') || line.chomp.start_with?('[')
  end

  def direction_row?(line)
    line.chomp.start_with?('move')
  end

  def clear_whitespace_between_columns
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

  def from_column_start_index(from)
    index = 0

    @boxes.each do |row|
      # empty slots take up three whitespace characters
      break if row[from - 1] != '   '

      index += 1
    end

    index
  end

  # TODO: double check conditional when calculcating this index
  def to_column_start_index(to)
    index = -1

    @boxes.each do |row|
      break if row[to - 1] != '   '

      index += 1
    end

    index
  end

  def select_boxes_to_move(amount, from, from_start_index)
    boxes = []

    (0...amount).each do |count|
      row_index = from_start_index + count

      boxes << @boxes[row_index][from - 1]
      @boxes[row_index][from - 1] = '   '
    end

    boxes
  end

  def move_boxes_to_desired_column(boxes_to_move, to, to_start_index, move_multiple)
    (0...boxes_to_move.size).each do |count|
      row_index = (to_start_index - count)
      box = move_multiple ? boxes_to_move.pop : boxes_to_move.shift

      if row_index.positive? || row_index.zero?
        @boxes[row_index][to - 1] = box
      else
        create_new_row_for_box(box, (to - 1), @boxes.last.size)
      end
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
