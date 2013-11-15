require 'twitter'
class TwitterSearcher
  include Celluloid
  attr_reader :since_id
  def initialize(credentials, queue)
    @client = Twitter::Client.new(credentials)
    @queue = queue
  end

  def search(q, since_id, manager)
    raise "Ow!#{q}" if rand(2) == 1
    results = client.search(q, since_id: since_id)
    results.statuses.each do |tweet|
      queue << tweet
    end
    since_id = results.statuses.inject(since_id) do |max, tweet|
      max > tweet.id ? max : tweet.id
    end
    manager.query_since(q, since_id)
  end

  private
  attr_reader :client, :queue
end
