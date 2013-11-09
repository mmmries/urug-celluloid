require 'twitter'
require 'twitter_searcher'
class TwitterListener
  include Celluloid
  def initialize(credentials, query, queue)
    @client = Twitter::Client.new(credentials)
    @query = query
    @queue = queue
    async.start_listening
  end

  def start_listening
    searcher = TwitterSearcher.new(client, query)
    while true
      searcher.each do |tweet|
        queue << tweet
      end
      sleep 5
    end
  end
  
  private
  attr_reader :client, :query, :queue
end
