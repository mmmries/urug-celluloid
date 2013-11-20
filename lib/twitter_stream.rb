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
      sleep rand(5)
    end
  end
end
