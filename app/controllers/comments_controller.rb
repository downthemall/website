class CommentsController < ApplicationController
  inherit_resources
  actions :all
  belongs_to :article

  load_and_authorize_resource :article
  load_and_authorize_resource :comment, :through => :article

  before_filter :generate_textcaptcha, :only => :new

  respond_to :js

  def create
    @comment.user = current_user if user_signed_in?
    @comment.session_id = session[:session_token]
    create!
  end

  private

  def generate_textcaptcha
    @comment.textcaptcha
  end

end
