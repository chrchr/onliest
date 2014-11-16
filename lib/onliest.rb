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

  # Return a new unique value, using the default random number
  # generator
  def self.value
    new.value
  end

  # Create a new unique value generator.
  # +prng+ defaults to +Random::DEFAULT+. An object that implements
  # +:rand+ returning a random integer between 0 and the value provided
  # as the first argument.
  def initialize(prng = Random::DEFAULT)
    @prng = prng
  end

  # Return the unique 72-bit value
  def value
    (some_time_bits << RANDOM_BITS) +
      some_random_bits
  end

  private

  def some_random_bits
    @prng.rand(RANDOM_BITMASK)
  end

  def some_time_bits
    Time.now.to_i & TIME_BITMASK
  end
end
