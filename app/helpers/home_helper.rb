module HomeHelper
  def favorite_tweets
    Twitter::Client.new.favorites("steffoz")[0..3]
  end

  def latest_news
    feed = FeedNormalizer::FeedNormalizer.parse open("http://www.downthemall.net/feed/rss/")
    feed.entries[0..2]
  end
end
