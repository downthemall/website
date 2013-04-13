class SystemSupport < Struct.new(:user_agent_string)
  def is_supported?
    user_agent.browser == 'Firefox'
  end

  def user_agent
    @user_agent ||= UserAgent.parse(user_agent_string)
  end
end

