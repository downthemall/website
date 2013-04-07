class Controller
  def self.routes
    @routes
  end

  %w(get post put delete patch head).each do |method|
    define_singleton_method(method) do |*args, &block|
      @routes ||= {}
      @routes[[method.to_sym, *args]] = block
    end
  end

  def self.install_routes!(context)
    routes.each do |route_args, block|
      context.send(*route_args, &block)
    end
  end

  def self.route_handler(method, name)
    @routes.each do |route_args, block|
      if route_args[0] == method && route_args[1] == name
        return block
      end
    end
    return nil
  end
end

