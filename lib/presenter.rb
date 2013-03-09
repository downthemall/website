class Presenter < SimpleDelegator
  attr_reader :context

  module Helpers
    def present(obj, klass = nil)
      if obj.is_a? Presenter
        obj
      elsif obj.is_a? Array
        obj.map { |o| present(o, klass) }
      else
        klass ||= "#{obj.class}Presenter".constantize
        klass.new(obj, self)
      end
    end
  end

  def model_name
    object.class.name
  end

  def initialize(obj, context)
    super(obj)
    @context = context
  end

  def object
    __getobj__
  end

  include Helpers
end
