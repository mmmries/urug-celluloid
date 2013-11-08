require 'twitter'
require 'twitter_searcher'
module Commands
  class Listen
    def initialize(queries, credentials)
      @credentials = credentials
      @client = Twitter::Client.new(credentials)
      @query = queries.first
      raise ArgumentError.new("You must provide one search term") unless @query
      @since_id = 0
    end

    def go
      searcher = TwitterSearcher.new(client, query)
      while true
        searcher.each do |tweet|
          print_tweet(tweet)
        end
        sleep 5
      end
    end

    private
    attr_reader :credentials, :client, :query, :since_id

    def print_tweet(tweet)
      puts "#{tweet.user.screen_name} :: #{tweet.created_at} :: #{tweet.text}"
    end
  end
end
