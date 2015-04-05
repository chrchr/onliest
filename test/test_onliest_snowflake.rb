require_relative './test_setup'
require 'onliest/snowflake'

class SnowflakeTests < TestCase
  def worker_number
    '13'
  end
  
  def generator
    Onliest::Snowflake.new(worker_number)
  end

  def test_snowflake_sign_bit_is_zero
    assert_equal(0, generator.value & (1 << 63))
  end

  def test_snowflake_time_with_millisecond_precision
    at(1.1234 + (Onliest::Snowflake::EPOCH.to_f / 1000)) do
      assert_equal(1123, generator.value >> 22)
    end
  end

  def test_snowflake_worker_number
    assert_equal(worker_number.to_i, (generator.value & (2**22 - 1)) >> 12)
  end

  def test_snowflake_sequence_starts_at_zero
    assert_equal(0, generator.value & ((2**12 - 1)))
  end

  def test_snowflake_sequence_increments
    at(Time.now.to_i) do
      gen = generator
      assert_equal(gen.value, gen.value - 1)
    end
  end
  
  def test_snowflake_epoch_starts_at_1288834974_657
    at(1288834974657.to_f / 1000) do
      assert_equal(0, generator.value >> 22)
    end
  end

  def test_time_always_goes_forward
    gen = generator
    times = [Onliest::Snowflake::EPOCH + 0.10,
             Onliest::Snowflake::EPOCH,
             Onliest::Snowflake::EPOCH + 0.11]
    
    Time.stub(:now, ->{ times.shift } ) do
      assert(gen.value < gen.value)
    end
  end
end
