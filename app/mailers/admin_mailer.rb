class AdminMailer
  def self.to_moderate!(revision)
    admins = User.admins.map(&:email)
    if admins.any? && !revision.author.admin?
      Downthemall.email do
        from 'do-not-reply@downthemall.net'
        to admins
        subject 'New KB article revision is waiting your moderation!'
        locals revision: RevisionPresenter.new(revision, self)
        content_type :plain
        body render('admin/revision_to_moderate')
      end
    end
  end
end
