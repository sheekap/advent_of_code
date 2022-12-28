require 'minitest/autorun'

require_relative 'solution'

# Tests for SupplyStacks class
class TestSupplyStacks < Minitest::Test
  def test_example
    stack = SupplyStacks.new('test_input.txt')
    stack.move_boxes

    expected_result = "CMZ"

    assert_equal expected_result, stack.print_top_boxes
  end

  def test_input
    stack = SupplyStacks.new('input.txt')
    stack.move_boxes

    expected_result = "TWSGQHNHL"

    assert_equal expected_result, stack.print_top_boxes
  end
end