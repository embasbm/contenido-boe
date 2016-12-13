# rubocop:disable LineLength
# rubocop:disable Metrics/AbcSize
# TwitterManager class
class TwitterManager
  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV['twitter_consumer_key']
      config.consumer_secret      = ENV['twitter_consumer_secret']
      config.access_token         = ENV['twitter_your_access_token']
      config.access_token_secret  = ENV['twitter_your_access_secret']
    end
    fetch_tweets('boe')
  end

  def fetch_tweets(keyword)
    @client.search("##{keyword} -rt", :lang => "es").each do |tweet|
      if tweet.created_at > 1.hour.ago && tweet.urls.count == 1 && tweet.urls.first.expanded_url.host.include?(keyword)
        @client.retweet!(tweet)
      end
    end
  end
end
