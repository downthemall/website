module ApplicationHelper

  def can_install?
    true
  end

  def switch_to_lang(locale)
    "/#{locale}"
  end

  def authorized?(instance_or_class, action)
    policy = if instance_or_class.is_a? Class
      Pundit.policy!(current_user, instance_or_class.new)
    else
      Pundit.policy!(current_user, instance_or_class)
    end
    policy.send("#{action}?")
  end
end

