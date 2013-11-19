require 'twitter'
module Commands
  class Listen
    def initialize(queries, credentials)
      @credentials = credentials
      @queries = queries
    end

    def go
      client = Twitter::Client.new(credentials)
      results = client.search(queries.first)
      results.statuses.each do |tweet|
        print_tweet(tweet)
      end
    end

    private
    attr_reader :credentials, :queries

    def print_tweet(tweet)
      puts "#{tweet.user.screen_name} :: #{tweet.created_at} :: #{tweet.text}"
    end
  end
end
