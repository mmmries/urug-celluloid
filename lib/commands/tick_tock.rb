module Commands
  class TickTock
    def initialize(env)
    end

    def go
      clock = GrandfatherClock.new(10)
      echoer = Echoer.new
      clock.wind(echoer)
      clock.wind(echoer, :tock)
    end
  end

  class GrandfatherClock
    include Celluloid

    def initialize(times)
      @times = times
    end

    def wind(output, msg = :tick)
      @times.times do
        output << msg
        sleep 1
      end
    end
  end

  class Echoer
    include Celluloid

    def <<(msg)
      p msg
    end
  end
end
