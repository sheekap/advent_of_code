require 'minitest/autorun'

require_relative 'solution'

# Tests for SupplyStacks class
class TestSupplyStacks < Minitest::Test
  def test_example_one_by_one
    stack = SupplyStacks.new('test_input.txt')
    stack.move_boxes

    expected_result = 'CMZ'

    assert_equal expected_result, stack.print_top_boxes
  end

  def test_input_one_by_one
    stack = SupplyStacks.new('input.txt')
    stack.move_boxes

    expected_result = 'TWSGQHNHL'

    assert_equal expected_result, stack.print_top_boxes
  end

  def test_example_multiple
    stack = SupplyStacks.new('test_input.txt')
    stack.move_boxes(move_multiple: true)

    expected_result = 'MCD'

    assert_equal expected_result, stack.print_top_boxes
  end

  def test_input_multiple
    stack = SupplyStacks.new('input.txt')
    stack.move_boxes(move_multiple: true)

    expected_result = 'JNRSCDWPP'

    assert_equal expected_result, stack.print_top_boxes
  end
end
