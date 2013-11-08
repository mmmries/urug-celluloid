require 'twitter'
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
      search_term = "##{@query}"
      puts "Searching for #{search_term}"
      search_for_term(search_term) do |tweet|
        @since_id = tweet.id if tweet.id > @since_id
        print_tweet(tweet)
      end
    end

    private
    attr_reader :credentials, :client, :query, :since_id

    def search_for_term(search_term, &block)
      results = client.search(search_term)
      yield_search_results(results,&block)
    end

    def yield_search_results(results,&block)
      begin
        results.statuses.each(&block)
        if results.next_page?
          next_page = results.next_page
          results = client.search(next_page.delete(:q), next_page)
        else
          results = nil
        end
      end while results
    end

    def print_tweet(tweet)
      puts "#{tweet.user.screen_name} :: #{tweet.created_at} :: #{tweet.text}"
    end
  end
end
