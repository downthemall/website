module DOMHelpers

  def dom_id_for(record)
    "#" + ActionController::RecordIdentifier.dom_id(record)
  end

  def dom_class_for(record)
    "." + ActionController::RecordIdentifier.dom_class(record)
  end

end

RSpec.configuration.include DOMHelpers, :type => :acceptance
