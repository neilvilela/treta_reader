require 'twitter'

class TwitterClient
  attr_accessor :tweet_id

  def initialize(tweet_id)
    self.tweet_id = tweet_id.to_s
  end

  def get_tweet
    Twitter::Tweet.new(get_tweet_hash)
  end

  def get_tweet_hash
    tweet = S3Client.get_tweet(tweet_id)
    tweet.presence || fetch_and_save
  end

  def fetch_and_save
    tweet = client.status(tweet_id, tweet_mode: "extended")
    S3Client.save_tweet(tweet)

    tweet.to_h
  end

  private

  def client
    @@client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Rails.application.credentials.twitter[:consumer_key]
      config.consumer_secret     = Rails.application.credentials.twitter[:consumer_secret]
      config.access_token        = Rails.application.credentials.twitter[:access_token]
      config.access_token_secret = Rails.application.credentials.twitter[:access_token_secret]
    end
  end
end
