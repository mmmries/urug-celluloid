require 'twitter_stream'
require 'thread'
module Commands
  class Listen
    def initialize(queries, credentials)
      @credentials = credentials
      @queries = queries
      @latest_map = Hash.new {|hash, key| hash[key] = 0}
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
    attr_reader :credentials, :queries, :latest_map

    def print_tweet(result)
      return nil unless new_tweet?(result)
      tweet = result[:tweet]
      puts "#{tweet.user.screen_name} :: #{tweet.created_at} :: #{tweet.text}"
    end

    def new_tweet?(result)
      tweet_id = result[:tweet].id
      query = result[:query]
      latest_id = latest_map[query]
      if tweet_id > latest_id
        latest_map[query] = tweet_id
        true
      else
        false
      end
    end
  end
end
