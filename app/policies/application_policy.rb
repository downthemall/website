class ApplicationPolicy < Struct.new(:user, :record)

  def self.multiple_actions(*actions, &block)
    actions.each do |action|
      define_method "#{action}?", &block
    end
  end

  def is_signed_in?
    user
  end

  def is_admin?
    user && user.admin?
  end

  def is_author?
    user == record.author
  end

end
