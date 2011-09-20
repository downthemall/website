module HomeHelper
  def favorite_tweets
    rv = Rails.cache.fetch("home/twitter", :expires_in => 2.hours) do 
      Twitter::Client.new.favorites("steffoz")[0..3]
    end
    logger.info rv
    rv
  end

  def latest_news
    rv = Rails.cache.fetch("home/latestnews", :expires_in => 2.hours) do
      feed = FeedNormalizer::FeedNormalizer.parse open("http://www.downthemall.net/feed/rss/")
      feed.entries[0..2]
    end
    logger.info rv
    rv
  end
end
