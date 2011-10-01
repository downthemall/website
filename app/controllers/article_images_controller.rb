class ArticleImagesController < ApplicationController
  inherit_resources
  actions :all, :except => [:show, :index]
  defaults :collection_name => :images
  belongs_to :article
  respond_to :js
end
