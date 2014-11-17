require 'securerandom'

# Onliest generates unique numbers for use as database keys in
# distributed applications. The values are composed of the rightmost
# 25 bits of a POSIX timestamp and 47 random bits.

# It uses the method described by Zack Bloom
# (https://eager.io/blog/how-long-does-an-id-need-to-be/).
class Onliest
  RANDOM_BITS = 47
  TIME_BITS = 25
  RANDOM_BITMASK = (2**RANDOM_BITS) - 1
  TIME_BITMASK = (2**TIME_BITS) - 1

  DEFAULT_RNG = SecureRandom

  # Return a new unique value, using the default random number
  # generator
  def self.value
    new.value
  end

  # Create a new unique value generator.  +rng+ defaults to
  # +SecureRandom+. An object that implements +:random_number+
  # returning a random integer >= 0 and less than value provided as
  # the first argument.
  def initialize(rng = DEFAULT_RNG)
    @rng = rng
  end

  # Return the unique 72-bit value
  def value
    (some_time_bits << RANDOM_BITS) +
      some_random_bits
  end

  private

  def some_random_bits
    @rng.random_number(RANDOM_BITMASK + 1)
  end

  def some_time_bits
    Time.now.to_i & TIME_BITMASK
  end
end
