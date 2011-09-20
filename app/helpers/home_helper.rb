module HomeHelper
  def favorite_tweets
    rv = Rails.cache.fetch("home/twitter", :expires_in => 2.hours) do 
      fetch_tweets
    end
    # FIXME: Find out WTF? is going on with <Hashie.Mash> serialization
    # when the cache gets slammed
    if not rv.respond_to?('each')
      logger.warn "twitter cache did not deserialize! was: #{rv}"
      rv = fetch_tweets
      Rails.cache.write "home/twitter", rv, :expires_in => 2.hours
    end
    rv
  end

  def latest_news
    Rails.cache.fetch("home/latestnews", :expires_in => 2.hours) do
      feed = FeedNormalizer::FeedNormalizer.parse open("http://www.downthemall.net/feed/rss/")
      feed.entries[0..2]
    end
  end

  private
  def fetch_tweets
    Twitter::Client.new.favorites("steffoz")[0..3]
  end
end
