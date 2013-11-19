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
      group = Celluloid::SupervisionGroup.run!
      streams = queries.map do |q|
        group.add(TwitterStream, args: [credentials, q, queue])
      end

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
