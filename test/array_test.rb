require 'test/test_helper'
require 'nested_access'

class ArrayTest < Test::Unit::TestCase

  def test_ambiguous_arguments
    assert_raises do
      [].nested_map(lambda {}) {}
    end
    assert_raises do
      [].nested_map(nil, lambda {}) {}
    end
    assert_raises do
      [].nested_map(lambda {}, lambda {}) {}
    end
  end

  def test_transform_empty_array
    assert_equal [], [].nested_map
  end

  def test_transform_element
    array = [0, 1, 2, 3]
    transformed = array.nested_map { |s| s + 1 }
    assert_equal [1, 2, 3, 4], transformed
  end

  def test_transform_nested_element
    array = [0, [1, 2], 3]
    transformed = array.nested_map { |s| s + 1 }
    assert_equal [1, [2, 3], 4], transformed
  end

  def test_transform_nested_element_within_nested_element
    array = [0, [1, 2, [3, 4, [5]]], 6]
    transformed = array.nested_map { |s| s + 1 }
    assert_equal [1, [2, 3, [4, 5, [6]]], 7], transformed
  end

  def test_transform_hash_within_array
    array = [0, 1, {:a => 2}]
    transformed = array.nested_map { |s| s + 1 }
    assert_equal [1, 2, {:a => 3}], transformed
  end

  def test_transform_hash_within_nested_array
    array = [0, 1, [2, {:a => 3}]]
    transformed = array.nested_map { |s| s + 1 }
    assert_equal [1, 2, [3, {:a => 4}]], transformed
  end

end
