@priorities = {
  a: 1, b: 2, c: 3, d: 4, e: 5, f: 6, g: 7, h: 8, i: 9, j: 10, k: 11, l: 12, m: 13,
  n: 14, o: 15, p: 16, q: 17, r: 18, s: 19, t: 20, u: 21, v: 22, w: 23, x: 24, y: 25, z: 26,
  A: 27, B: 28, C: 29, D: 30, E: 31, F: 32, G: 33, H: 34, I: 35, J: 36, K: 37, L: 38, M: 39,
  N: 40, O: 41, P: 42, Q: 43, R: 44, S: 45, T: 46, U: 47, V: 48, W: 49, X: 50, Y: 51, Z: 52 
}

input_file = File.join(File.dirname(__FILE__), 'input.txt')
@file = File.open(input_file)

def sum_priorities
  sum = 0

  @file.each do |line|
    common_items = []

    items = line.chars
    first_comp = items.slice(0, (items.length / 2))
    second_comp = items.slice((items.length / 2), items.length)

    first_comp.each { |item| common_items << item if second_comp.include?(item) }

    common_items = common_items.uniq

    if common_items.size != 1
      puts "Houston, we have a problem. Common items: #{common_items}, line: #{line}"
    else
      sum += @priorities[common_items.first.to_sym]
    end
  end

  sum
end

def sum_group_priorities
  sum = 0

  @file.each_slice(3) do |group|
    first, second, third = group.sort_by(&:length)
    common_items = []

    first.chomp.each_char do |item|
      common_items << item if second.chomp.include?(item) && third.chomp.include?(item)
    end

    common_items = common_items.uniq
    sum += @priorities[common_items.first.to_sym]
  end

  sum
end

# puts "Sum of priorities for all common items: #{sum_priorities}"
puts "Sum of priorities for common item per groups of three: #{sum_group_priorities}"
