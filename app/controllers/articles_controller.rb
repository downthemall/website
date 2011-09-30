class ArticlesController < ApplicationController
  inherit_resources
  actions :all, :except => :show
  respond_to :html

  layout :layout_by_action

  private

  def layout_by_action
    if %(create new edit update destroy).include? action_name
      "editing"
    else
      "application"
    end
  end

end
