class CommentsController < ApplicationController
  inherit_resources
  actions :all
  respond_to :js
  belongs_to :article
end
