require 'twitter_searcher'

class ListenPool
  include Celluloid

  def initialize(credentials, queries, queue)
    @credentials, @queue = queries, queue
    @queries = queries.inject({}){|hash, q| hash.merge(q => 0)}
    @pool = TwitterSearcher.pool(size: queries.size, args: [credentials, queue])
  end

  def listen
    while true
      queries.each do |q, since_id|
        pool.async.search(q, since_id, self)
      end
      sleep 5
    end
  end

  def query_since(q, id)
    queries[q] = id
  end

  private
  attr_reader :queries, :pool
end
