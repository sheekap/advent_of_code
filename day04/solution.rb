input = File.join(File.dirname(__FILE__), 'input.txt')
@file = File.open(input)

def count_overlap(full = true)
  count = 0

  @file.each do |pair|
    e1, e2 = pair.chomp.split(',')

    e1_start, e1_end = e1.split('-').map(&:to_i)
    e2_start, e2_end = e2.split('-').map(&:to_i)

    if full
      count += 1 if (e1_start <= e2_start && e1_end >= e2_end) || (e2_start <= e1_start && e2_end >= e1_end)
    else
      count += 1 if (e1_end >= e2_start) && (e1_start <= e2_end)
    end
  end

  count
end

# puts "No. of pairs where one assignment fully covers the other: #{count_overlap}"
puts "No. of pairs with partially overlapping areas: #{count_overlap(false)}"
