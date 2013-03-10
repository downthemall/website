class ModerationMailDeliver
  def self.to_moderate!(revision)
    if User.admins.any?
      Downthemall.deliver(:admin, :revision_to_moderate, revision)
    end
  end
end
