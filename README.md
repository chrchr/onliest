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
  def self.rand(max)
    SecureRandom.random_number(max)
  end
end

Onliest.new(MyPrng).value

```
