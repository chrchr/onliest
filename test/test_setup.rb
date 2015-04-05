require 'minitest/autorun'

class TestCase < Minitest::Test
  def at(value)
    Time.stub(:now, Time.at(value)) do
      yield
    end
  end

  def fake_prng(value = 1)
    fake_prng = Minitest::Mock.new
    fake_prng.expect(:random_number, value, [2**47])
  end
end

