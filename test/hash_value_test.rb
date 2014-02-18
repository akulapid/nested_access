require 'test/test_helper'
require 'nested_access'

class HashValueTest < Test::Unit::TestCase

  def test_ambiguous_arguments
    assert_raises do
      {}.nested_map(nil, lambda {}) {}
    end
  end

  def test_empty_hash
    assert_equal({}, {}.nested_map)
  end

  def test_transform_hash_value
    hash = {
        'a' => 'foo',
    }
    transformed = hash.nested_map { |v| v.to_sym }
    assert_equal :foo, transformed['a']
  end

  def test_transform_nested_hash_value
    hash = {
        'a' => 'foo',
        'b' => {
            'c' => 'bar'
        }
    }
    transformed = hash.nested_map { |v| v.to_sym }
    assert_equal :bar, transformed['b']['c']
  end

  def test_transform_hash_values_nested_within_arrays
    hash = {
        'a' => 'foo',
        'b' => [{'c' => {'d' => 'bar'}}]
    }
    transformed = hash.nested_map { |v| v.to_sym }
    assert_equal :bar, transformed['b'].first['c']['d']
  end

  def test_transform_hash_values_nested_within_arrays_nested_within_hash
    hash = {
        'a' => 'foo',
        'b' => {
            'c' => [{'c' => {'d' => 'bar'}}]
        }
    }
    transformed = hash.nested_map { |v| v.to_sym }
    assert_equal :bar, transformed['b']['c'].first['c']['d']
  end

  def test_transform_hash_values_nested_within_nested_arrays
    hash = {
        'a' => 'foo',
        'b' => {
            'c' => ['fuu', ['qux', {'c' => {'d' => 'bar'}}]]
        }
    }
    transformed = hash.nested_map { |v| v.to_sym }
    assert_equal :bar, transformed['b']['c'][1][1]['c']['d']
  end

  def test_do_nothing_to_keys
    hash = {
        'a' => 'foo',
        'b' => {
            'c' => ['fuu', ['qux', {'c' => {'d' => 'bar'}}]]
        }
    }
    transformed = hash.nested_map nil, lambda { |v| v.to_sym }
    assert_equal :bar, transformed['b']['c'][1][1]['c']['d']
  end

end
