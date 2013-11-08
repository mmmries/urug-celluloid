class TwitterSearcher
  attr_reader :since_id
  def initialize(client, q, since_id = nil)
    @client, @q, @since_id = client, q, since_id
  end

  def each(&block)
    search_for_term do |tweet|
      @since_id = tweet.id if since_id.nil? || tweet.id > since_id
      block.call(tweet)
    end
  end

  private
  attr_reader :client, :q
  def search_for_term(&block)
    results = client.search(q)
    results.statuses.each(&block)
  end
end
