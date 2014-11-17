Onliest
=======

Onliest generates unique numbers for use as database keys in
distributed applications.

It uses the method described by Zack Bloom (https://eager.io/blog/how-long-does-an-id-need-to-be/).

The generated values are numerically near one another, to provide
locality in database indexes, and are smaller than UUIDs while still
providing a low probability of collisions. The values are 72 bits and
include the rightmost 25 bits of the POSIX epoch and 47 bits of random
data.

E.g.,

```ruby

require 'onliest'

Onliest.value # => 958771797256631841372
Onliest.value # => 958771936749326691340

```

You may provide a custom random number generator as well:

```ruby

class MyPrng
  def self.random_number(max)
    Random::DEFAULT.rand(max)
  end
end

Onliest.new(MyPrng).value

```


The Probability of Collison
---------------------------

If 1,000 onliest values are generated in a second, the odds of a
collision are 1 in 281 million.

Note that the timestamp part of an onliest value reoccurs
approximately every 388 days, and collisions are possible with values
generated in the same second and with those created in the
corresponding second in previous revolutions of the timestamp
sequences.
