xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title "DownThemAll! Latest News"
    xml.link url(:articles, :index, format: :rss)
    
    @articles.each do |article|
      article = present(article)
      xml.item do
        xml.title article.title
        xml.description article.content
        xml.pubDate article.posted_at_rss
        xml.link url(:articles, :show, id: article)
        xml.guid url(:articles, :show, id: article)
      end
    end
  end
end
