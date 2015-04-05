require_relative './test_setup'
require 'onliest'

# Tests for the dkjefault scheme

class OnliestDefaultTest < TestCase
  def test_generates_a_number
    assert_kind_of(Integer, Onliest.value)
  end

  def test_values_are_different
    refute_equal(Onliest.value, Onliest.value)
  end

  def fake_prng(value = 1)
    fake_prng = Minitest::Mock.new
    fake_prng.expect(:random_number, value, [2**47])
  end

  def test_with_a_time_and_a_prng
    at((2**25) + 1) do
      random_value = 2
      gen = Onliest.new(rng: fake_prng(random_value))
      assert_equal((1 << 47) + random_value, gen.value)
    end
  end

  def test_the_littlest_onliest
    at(0) do
      gen = Onliest.new(rng: fake_prng(0))
      assert_equal(gen.value, 0)
    end
  end

  def test_the_largest_onliest
    at(2**25 - 1) do
      gen = Onliest.new(rng: fake_prng(2**47 - 1))
      assert_equal(2**72 - 1, gen.value)
    end
  end
end
