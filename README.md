Onliest
=======

Onliest generates unique numbers for use as database keys in
distributed applications. It includes a scheme for generating 72-bit
probabilistically unique values and Twitter's deterministically unique
64-bit Snowflake scheme. It also permits the implementation of
application specific uniqueness schemes.

Default Probabilistic Uniqueness Scheme
======================================

By default, Onliest uses the method described by Zack Bloom (https://eager.io/blog/how-long-does-an-id-need-to-be/).

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

Onliest.new(rng: MyPrng).value

```

The Probability of Collision
---------------------------

If 1,000 onliest values are generated in a second, the odds of a
collision are 1 in 281 million.

Note that the timestamp part of an onliest value re-occurs
approximately every 388 days, and collisions are possible with values
generated in the same second and with those created in the
corresponding second in previous revolutions of the timestamp
sequences.

Snowflake: Compact, Deterministic Uniqueness
===================================

At the cost of some coordination, the Snowflake scheme from Twitter
(https://blog.twitter.com/2010/announcing-snowflake) provides
semi-ordered unique values in 64 bits. The values include 41-bits of
milliseconds since an epoch, a 10-bit worker number, and a 12-bit
sequence value. The worker number must be provided by the application,
and it is assumed that each Snowflake generator instance will have a
unique worker number. In Twitter's implementation of this scheme, the
worker number is coordinated through Zookeeper.

To protect against collisions caused by clock skew, the time component
is guaranteed not to go backward. The generator includes a check that
the time value is not less than the previous one.

Example
-------
```ruby

require 'onliest/snowflake'

snowflake_generator = Onliest::Snowflake.new(ENV.fetch('WORKER_NUMBER'))

snowflake_generator.value # => 5120933234229645312
snowflake_generator.value # => 5120933234246422529

```

Application Defined Uniqueness Schemes
======================================

To facilitate custom schemes, Onliest can take a field map which
specifies a list of fields with a size in bits and a callable
generator for each. The fields are ordered from left-to-right. Values
produced by the callable generators are converted to integers and
values larger than the specified field size overflow.

Example
-------

```ruby

require 'onliest'

# This is 32 bits of milliseconds, the 16-bit process ID, and a 16-bit sequence
sequence = 0
generator = Onliest.new(fields: [{bits: 32,
                                  generator: ->{ (Time.now.to_f * 1000) } },
                                 {bits: 16,
                                  generator: ->{ Process.pid } },
                                 {bits: 16,
                                  generator: ->{ sequence += 1 } }])

generator.value # => 10070521132285886465
generator.value # => 10070534395144896514

```

Changes
=======

0.10 - Introduces the Snowflake scheme and facilities for custom uniqueness schemes.
0.02 - Initial release.
