require 'twitter_stream'
require 'thread'
module Commands
  class Listen
    def initialize(queries, credentials)
      @credentials = credentials
      @queries = queries
    end

    def go
      queue = Queue.new
      streams = queries.map do |q|
        TwitterStream.new(credentials, q)
      end
      streams.each{|stream| stream.async.stream(queue)}

      while true
        print_tweet( queue.pop )
      end
    end

    private
    attr_reader :credentials, :queries

    def print_tweet(tweet)
      puts "#{tweet.user.screen_name} :: #{tweet.created_at} :: #{tweet.text}"
    end
  end
end
