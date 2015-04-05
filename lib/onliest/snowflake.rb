require 'onliest'

class Onliest::Snowflake < Onliest
  attr_reader :worker_number, :sequence

  # This comes from twitter snowflake. I'm not
  # sure how they arrived at this number.
  # November 3, 2010 at 11:42:55
  EPOCH = 1288834974657
  
  def initialize(worker_number)
    @worker_number = worker_number
    @sequence = 0
    @older_time = 0
    super(fields: [{ bits: 1, generator: ->{ 0 } },
                   { bits: 41, generator: ->{ time } },
                   { bits: 10, generator: ->{ worker_number } },
                   { bits: 12, generator: ->{ sequence_nextval } }])
  end

  private
  
  def sequence_nextval
    i = @sequence
    @sequence = @sequence.succ
    i
  end

  def time
    while (t = time_now) < @older_time
      #puts @older_time
      #puts t
      sleep((@older_time - t) / 1000)
    end
    @older_time = t
    t
  end
  
  def time_now
    ((Time.now.to_f * 1000).to_i - EPOCH)
  end
end
