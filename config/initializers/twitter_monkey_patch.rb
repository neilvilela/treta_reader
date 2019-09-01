class Twitter::Tweet
  def text
    if truncated? && attrs[:extended_tweet]
      # Streaming API, and REST API default
      t = attrs[:extended_tweet][:full_text]
    else
      # REST API with extended mode, or untruncated text in Streaming API
      t = attrs[:text] || attrs[:full_text]
    end
  end
end