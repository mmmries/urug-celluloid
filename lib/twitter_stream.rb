require 'twitter_searcher'

class TwitterStream
  include Celluloid

  attr_reader :searcher

  def initialize(credentials, query)
    @searcher = TwitterSearcher.new(credentials, query)
  end

  def stream(queue)
    while true
      searcher.each do |tweet|
        queue << tweet
      end
      sleep 5
    end
  end
end
