class RevisionsController < ApplicationController
  def index
  end

  def new
    @revision = Revision.new
    authorize! @revision
  end

  def show
    @revision = Revision.find(params[:id])
  end

  def create
    @revision = Revision.build(I18n.locale, current_user, params[:revision])
    authorize! @revision
    if @revision.save
      AdminMailer.revision_to_moderate(@revision).deliver # if @revision != @old_revision
      redirect_to @revision, notice: I18n.t('knowledge_base.created')
    else
      render 'knowledge_base/new'
    end
  end

  def edit
    @revision = Revision.find(params[:id]).latest_revision
    authorize! @revision
  end

  def update
    @old_revision = Revision.find(params[:id])
    authorize! @old_revision
    @revision = @old_revision.build_updated(current_user, params[:revision])
    if @revision.save
      AdminMailer.revision_to_moderate(@revision).deliver # if @revision != @old_revision
      flash[:notice] = I18n.t('knowledge_base.updated')
      redirect_to revision_path(@revision, locale: @revision.locale)
    else
      render 'knowledge_base/edit'
    end
  end

  def destroy
    @revision = Revision.find(params[:id])
    authorize! @revision
    @revision.destroy!
    flash[:notice] = I18n.t('knowledge_base.destroyed')
    redirect_to revisions_path
  end

  def approve
    @revision = Revision.find(params[:id])
    authorize! @revision
    @revision.approve!
    flash[:notice] = I18n.t('knowledge_base.approved')
    redirect_to @revision
  end
end

