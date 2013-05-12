admin = User.new(email: 'stefano.verna@gmail.com')
admin.admin = true
admin.save!

posts = JSON.parse File.read(Rails.root.join('db/posts.json'))
posts.each do |post|
  Post.create!(
    title: post['title'],
    content: post['md_body'],
    posted_at: post['date'],
    author: admin
  )
end

