class TwitterSearcher
  attr_reader :since_id
  def initialize(client, q, since_id = 0)
    @client, @q, @since_id = client, q, since_id
  end

  def each(&block)
    raise "Ow!#{q}" if rand(3) == 1
    search_for_term do |tweet|
      @since_id = tweet.id if tweet.id > since_id
      block.call(tweet)
    end
  end

  private
  attr_reader :client, :q
  def search_for_term(&block)
    results = client.search(q, since_id: since_id)
    results.statuses.each(&block)
  end
end
