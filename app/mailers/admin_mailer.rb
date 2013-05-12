class AdminMailer < ActionMailer::Base
  default from: 'do-not-reply@downthemall.net'

  def revision_to_moderate(revision)
    admins = User.admins.map(&:email)
    if admins.any? && !revision.author.admin?
      @revision = RevisionPresenter.new(revision, self)
      mail(to: admins, subject: 'New KB article revision is waiting your moderation!')
    end
  end
end

