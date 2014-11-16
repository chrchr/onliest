require 'minitest/autorun'

require 'onliest'

class OnliestTest < Minitest::Unit::TestCase
  def test_generates_a_number
    assert_kind_of(Integer, Onliest.value)
  end

  def test_values_are_different
    refute_equal(Onliest.value, Onliest.value)
  end

  def fake_prng(value = 1)
    fake_prng = Minitest::Mock.new
    fake_prng.expect(:rand, value, [(2**47) - 1])
  end

  def test_with_a_time_and_a_prng
    Time.stub(:now, Time.at(2**25) + 1) do
      random_value = 2
      gen = Onliest.new(fake_prng(random_value))
      assert_equal(gen.value, (1 << 47) + random_value)
    end
  end
end
