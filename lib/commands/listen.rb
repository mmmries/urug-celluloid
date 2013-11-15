require 'listen_pool'
require 'thread'

module Commands
  class Listen
    def initialize(queries, credentials)
      @credentials = credentials
      @queries = queries
    end

    def go
      queue = Queue.new
      pool = ListenPool.new(credentials, queries, queue)
      pool.async.listen
      while true
        print_tweet(queue.pop)
      end
    end

    private
    attr_reader :credentials, :queries

    def print_tweet(tweet)
      puts "#{tweet.user.screen_name} :: #{tweet.created_at} :: #{tweet.text}"
    end
  end
end
