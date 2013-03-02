class RecordFactory
  include Singleton

  def user_attrs
    {
      email: 'foo@gmail.com',
      password: 'foobar'
    }
  end

  def donation_attrs
    {
      amount: 5,
      status: Donation::STATUS_PENDING,
      currency: 'USD'
    }
  end

  private

  def init_with_attrs(klass, attrs)
    record = klass.new
    attrs.each do |k,v|
      record.send("#{k}=", v)
    end
    record
  end

  def method_missing(method, *args, &block)
    if method.to_s =~ /^(.+)!$/
      b = send($1, *args)
      b.save!
      b
    elsif respond_to? "#{method}_attrs"
      model_klass = method.to_s.classify.constantize
      attrs = send("#{method}_attrs")
      attrs.merge!(args.first) if args.any?
      init_with_attrs(model_klass, attrs)
    else
      super
    end
  end
end

module FactoryHelper
  def factory
    RecordFactory.instance
  end
end

RSpec.configuration.include FactoryHelper
