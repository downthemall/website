class VersionsController < ApplicationController
  inherit_resources
  belongs_to :article
  belongs_to :article_translation, :collection_name => :translations
  actions :show, :index
  respond_to :html
end

