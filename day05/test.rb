require 'minitest/autorun'

require_relative 'solution'

class TestSupplyStacks < Minitest::Test
  def test_example
    stack = SupplyStacks.new('test_input.txt')
    stack.move_boxes

    expected_result = "CMZ"

    assert_equal expected_result, stack.print_top_boxes
  end
end