require 'twitter'

class TwitterSearcher
  attr_reader :client, :query, :since_id
  def initialize(credentials, query)
    @client = Twitter::Client.new(credentials)
    @query = query
    @since_id = 0
  end

  def each(&block)
    client.search(query, since_id: since_id).statuses.each do |tweet|
      @since_id = tweet.id if tweet.id > @since_id
      block.call(tweet)
    end
  end
end
