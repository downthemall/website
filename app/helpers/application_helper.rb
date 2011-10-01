module ApplicationHelper

  def form_error_messages(resource)
    if resource.errors.present?
      content_tag :ul, {:class => "form_errors"} do
        resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join.html_safe
      end
    else
      ""
    end
  end

  class MainFormBuilder < SimpleForm::FormBuilder
    def button(type, *args, &block)
      options = args.extract_options!
      options[:class] = ["safe primary big button", options[:class]].compact.join(" ")
      args << options
      super(type, *args, &block)
    end
  end

  class MinorFormBuilder < SimpleForm::FormBuilder
    def button(type, *args, &block)
      options = args.extract_options!
      options[:class] = ["safe primary button", options[:class]].compact.join(" ")
      args << options
      super(type, *args, &block)
    end
  end

  def main_form_for(object, *args, &block)
    options = args.extract_options!
    simple_form_for(object, *(args << options.merge(:builder => MainFormBuilder)), &block)
  end

  def minor_form_for(object, *args, &block)
    options = args.extract_options!
    simple_form_for(object, *(args << options.merge(:builder => MinorFormBuilder)), &block)
  end

  def escape_partial(partial, locals = {})
    escape_javascript(render(partial, locals))
  end

end
