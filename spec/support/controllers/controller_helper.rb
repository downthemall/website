class MockController
  attr_reader :rendered_view
  attr_reader :redirect_url
  attr_reader :flash
  attr_reader :assigns
  attr_accessor :session
  attr_accessor :params
  attr_accessor :request

  class Redirect < RuntimeError; end

  class Flash < Hash
    def now
      @now ||= {}
    end
  end

  def initialize
    @rendered_view = nil
    @redirect_url = nil
    @flash = Flash.new
    @session = {}
    @assigns = {}
    @request = {}
  end

  def render(view)
    @rendered_view = view
  end

  def redirect(url)
    @redirect_url = url
    raise Redirect
  end
  alias_method :redirect_to, :redirect

  def url(*args)
    args
  end

  def perform_request(&block)
    variables_before = instance_variables
    instance_exec(&block)
    variables_after = instance_variables
    (variables_after - variables_before).each do |name|
      @assigns[name.to_s.sub(/@/,'').to_sym] = instance_variable_get(name)
    end
  rescue Redirect
  end

  include Downthemall::Helpers
end

module ControllerHelper
  def controller
    @controller ||= MockController.new
  end

  def make_request(method, name, params = {})
    controller.params = params
    controller.perform_request(&subject.class.route_handler(method, name))
  end

  def session
    controller.session
  end

  def flash
    controller.flash
  end

  def rendered_view
    controller.rendered_view
  end

  def redirect_url
    controller.redirect_url
  end

  def assigns
    controller.assigns
  end

  %w(get post put delete patch head).each do |method|
    define_method(method) do |name, params = {}|
      make_request(method.to_sym, name, params)
    end
  end
end

RSpec.configuration.include ControllerHelper
