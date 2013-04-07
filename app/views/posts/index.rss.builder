xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title I18n.t('blog.rss.title')
    xml.link url(:posts, :index, format: :rss)
    
    @posts.each do |post|
      post = present(post)
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.posted_at_rss
        xml.link url(:posts, :show, id: post)
        xml.guid url(:posts, :show, id: post)
      end
    end
  end
end

