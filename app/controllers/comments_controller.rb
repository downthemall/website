class CommentsController < ApplicationController
  inherit_resources
  actions :all
  belongs_to :article

  load_and_authorize_resource :article
  load_and_authorize_resource :comment, :through => :article

  respond_to :js

  def create
    @comment.user = current_user if user_signed_in?
    create!
  end

end
