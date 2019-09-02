module S3Client
  def self.initialize!
    client_config = {
                      access_key_id: Rails.application.credentials.aws[:access_key],
                      secret_access_key: Rails.application.credentials.aws[:access_secret],
                      region: Rails.application.credentials.aws[:region]
                    }
    @@client ||= Aws::S3::Client.new(client_config)
  end


  module_function

  def get_tweet(tweet_id)
    JSON.parse(client.get_object(bucket: Rails.application.credentials.aws[:bucket], key: "tweets/#{tweet_id}.json").body.read).with_indifferent_access
  rescue
    nil
  end

  def get_thread(thread_id)
    JSON.parse(client.get_object(bucket: Rails.application.credentials.aws[:bucket], key: "threads/#{thread_id}.json").body.read).map(&:with_indifferent_access)
  rescue
    nil
  end

  def save_tweet(tweet)
    return if ENV["SKIP_S3"]
    client.put_object(body: tweet.to_json, bucket: Rails.application.credentials.aws[:bucket], key: "tweets/#{tweet.id}.json")
  rescue
    # Do not throw errors
  end

  def save_thread(thread_id, thread)
    return if ENV["SKIP_S3"]
    client.put_object(body: thread.map(&:to_h).to_json, bucket: Rails.application.credentials.aws[:bucket], key: "threads/#{thread_id}.json")
  rescue
    # Do not throw errors
  end

  def client
    @@client
  end
end

S3Client.initialize!