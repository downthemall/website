Downthemall.mailer :admin do
  email :revision_to_moderate do |revision|
    from 'do-not-reply@downthemall.net'
    to User.admins.map(&:email)
    subject 'New KB article revision is waiting your moderation!'
    locals revision: RevisionPresenter.new(revision, self)
    content_type :plain
    render 'admin/revision_to_moderate'
  end
end
