require 'twitter_searcher'
module Commands
  class Listen
    def initialize(queries, credentials)
      @credentials = credentials
      @queries = queries
    end

    def go
      searcher = TwitterSearcher.new(credentials, queries.first)
      while true
        searcher.each do |tweet|
          print_tweet(tweet)
        end
        sleep 5
      end
    end

    private
    attr_reader :credentials, :queries

    def print_tweet(tweet)
      puts "#{tweet.user.screen_name} :: #{tweet.created_at} :: #{tweet.text}"
    end
  end
end
