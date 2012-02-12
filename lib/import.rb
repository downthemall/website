require 'rubygems'
require 'mechanize'

posts = []

19.times do |index|
  a = Mechanize.new
  page = a.get("http://www.downthemall.net/latest/category/uncategorized/page/#{index}")
  page.search("#corpo-pagina > .indent").each do |el|
    title = el.search("h3 a").first.content
    date = DateTime.strptime(el.search("h3 i").first.content, "%B %e, %Y") rescue el.search("h3 i").first.content
    content = el.search(".indent").inner_html
    File.open("temp.txt", "w") {|file| file.puts(content)}
    content = `html2textile temp.txt`
    posts << {:title => title, :posted_at => date, :content => content, :public => true }
    puts posts.last.inspect
  end
end

File.open("posts.yaml", "w") {|file| file.puts(posts.to_yaml) }
