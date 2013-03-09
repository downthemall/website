module AttrInitializer

  def initialize(attrs = {})
    attrs.each do |k, v|
      if respond_to? k
        instance_variable_set "@#{k}", v
      else
        raise RuntimeError, "#{k} is not a valid attribute"
      end
    end
  end

  def attr_values(*keys)
    if keys.size == 0
      keys = instance_variables.map { |k| k.to_s.sub(/^@/, '') }
    end
    Hash[keys.map { |k| [ k.to_sym, instance_variable_get("@#{k}") ] } ]
  end

end
