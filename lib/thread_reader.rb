# Tweet de exemplo: https://twitter.com/luide/status/1147919130349264896
require 'twitter_client'

class ThreadReader
  attr_accessor :thread, :tweet_id
  attr_reader :initial_tweet

  def initialize(tweet_id)
    self.tweet_id = tweet_id

    if @from_s3 = S3Client.get_thread(tweet_id)
      self.thread = @from_s3.map { |tweet| Twitter::Tweet.new(tweet) }
    else
      self.thread = [initial_tweet]
    end
  end

  def initial_tweet
    @initial_tweet ||= TwitterClient.new(tweet_id).get_tweet
  end

  def unroll
    return thread if @from_s3

    tweet = initial_tweet

    while has_previous_tweet?(tweet)
      tweet = get_previous_tweet(tweet)
      thread.unshift(tweet)
    end

    S3Client.save_thread(tweet_id, thread)

    thread
  end

  def get_previous_tweet(tweet)
    if tweet.quoted_tweet? && tweet.quoted_tweet.urls.any?
      TwitterClient.new(tweet.quoted_tweet.id).get_tweet
    elsif tweet.quoted_tweet?
      tweet.quoted_tweet
    elsif tweet.reply?
      TwitterClient.new(tweet.in_reply_to_status_id).get_tweet
    else
    end
  end

  def has_previous_tweet?(tweet)
    tweet.quoted_tweet? || tweet.reply?
  end
end
