module ThreadsHelper
  def format_tweet(tweet)
    final_text = tweet.text

    if final_text.include?("https")
      final_text = final_text.split("https")[0..-2].join("https")
    end

    simple_format final_text
  end

  def media_has_image?(media)
    media.type == "photo" || media.type == "animated_gif" || media.type == "video"
  end
end
