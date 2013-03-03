admin = Authentication.create_user('stefano.verna@gmail.com', 'changeme')
admin.admin = true
admin.save!

articles = JSON.parse File.read(Padrino.root('db/articles.json'))
articles.each do |article|
  Article.create!(
    title: article['title'],
    content: article['md_body'],
    posted_at: article['date'],
    author: admin
  )
end
