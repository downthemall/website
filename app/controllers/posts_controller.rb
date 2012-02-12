class PostsController < ApplicationController
  inherit_resources
  actions :all
  respond_to :html

  load_and_authorize_resource :post

  def create
    @post.author = current_user
    create!
  end

end
