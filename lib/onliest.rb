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
  def initialize(rng: DEFAULT_RNG, fields: false)
    @fields = fields ? fields : default_fields(rng)
  end

  # Construct and return the unique value
  def value
    total_bits = 0
    total_value = 0
    @fields.reverse.each do |field|
      bits = field.fetch(:bits)
      field_value = Integer(field.fetch(:generator).call) & ((2**bits) - 1)
      total_value += (field_value << total_bits)
      total_bits += bits
    end
    total_value
  end

  private

  def default_fields(rng)
    [{ bits: TIME_BITS, generator: -> { Time.now.to_i } },
     { bits: RANDOM_BITS,
       generator: -> { rng.random_number(RANDOM_BITMASK + 1) } }]
  end
end
