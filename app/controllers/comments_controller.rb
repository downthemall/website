class CommentsController < ApplicationController
  inherit_resources
  actions :all
  respond_to :js
end
