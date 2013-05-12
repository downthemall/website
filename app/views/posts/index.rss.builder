xml.instruct! :xml, version: "1.0" 
xml.rss version: "2.0" do
  xml.channel do
    xml.title I18n.t('blog.rss.title')
    xml.link posts_path(format: :rss)
    
    @posts.each do |post|
      post = present(post)
      xml.item do
        xml.title post.title
        xml.description post.content
        xml.pubDate post.posted_at_rss
        xml.link post_path(@post)
        xml.guid post_path(@post)
      end
    end
  end
end

