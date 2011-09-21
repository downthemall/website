module HomeHelper
  AMO_URL = 'https://addons.mozilla.org/statistics/addon/201'
  TWITTER_ACCOUNT = 'steffoz'
  FEED_URL = 'http://www.downthemall.net/feed/rss'

  EXPIRES_IN = 2.hours

  def favorite_tweets
    Rails.cache.fetch("home/twitter", :expires_in => EXPIRES_IN) do 
      Twitter::Client.new.favorites(TWITTER_ACCOUNT)[0..3]
    end
  end

  def latest_news
    Rails.cache.fetch("home/latestnews", :expires_in => EXPIRES_IN) do
      feed = FeedNormalizer::FeedNormalizer.parse open(FEED_URL)
      feed.entries[0..2]
    end
  end

  def amo_stats
    Rails.cache.fetch("home/amostats", :expires_in => EXPIRES_IN) do 
      # Note: there is no real stats API yet (only stats per day as CSV/JSON)
      amo = Nokogiri::HTML(open(AMO_URL))
      amo = amo.css('#stats-table-container .bigvalue').map {|x| x.content.gsub(/\W/,'').to_i }
      Hashie::Mash.new({:downloads => amo[0], :users => amo[1]})
    end
  end
end
