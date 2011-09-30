class ArticleTranslationsController < ApplicationController
  inherit_resources
  actions :show
  defaults :collection_name => :translations
  belongs_to :article
  respond_to :html

end

