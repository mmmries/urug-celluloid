require 'twitter_searcher'

class TwitterStream
  include Celluloid

  attr_reader :searcher, :queue, :query

  def initialize(credentials, query, queue)
    @searcher = TwitterSearcher.new(credentials, query)
    @queue = queue
    @query = query
    async.stream
  end

  def stream
    while true
      raise "Ouch" if rand(3) == 1
      searcher.each do |tweet|
        queue << {query: query, tweet: tweet}
      end
      fib(38)
    end
  end

  private
  def fib(n)
    return 1 if n == 0 || n == 1
    fib(n-1) + fib(n-2)
  end
end
