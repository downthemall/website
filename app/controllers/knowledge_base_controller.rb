class KnowledgeBaseController < Controller
  get :index, map: '/knowledge-base' do
    render 'knowledge_base/index'
  end

  get :new, map: '/knowledge-base/new' do
    @revision = Revision.new
    authorize! @revision
    render 'knowledge_base/new'
  end

  get :show, map: '/knowledge-base/:id' do
    @revision = Revision.find(params[:id])
    render 'knowledge_base/show'
  end

  post :create, map: '/knowledge-base' do
    @revision = Revision.build(I18n.locale, current_user, params[:revision])
    authorize! @revision
    if @revision.save
      ModerationMailDeliver.to_moderate!(@revision)
      flash[:notice] = I18n.t('knowledge_base.created')
      redirect url(:knowledge_base, :show, id: @revision)
    else
      render 'knowledge_base/new'
    end
  end

  get :edit, map: '/knowledge-base/:id/edit' do
    @revision = Revision.find(params[:id]).latest_revision
    authorize! @revision
    render 'knowledge_base/edit'
  end

  post :update, map: '/knowledge-base/:id' do
    @revision = Revision.find(params[:id])
    authorize! @revision
    @revision = @revision.build_updated(current_user, params[:revision])
    if @revision.save
      ModerationMailDeliver.to_moderate!(@revision)
      flash[:notice] = I18n.t('knowledge_base.updated')
      redirect url(:knowledge_base, :show, id: @revision)
    else
      render 'knowledge_base/edit'
    end
  end

  get :destroy, map: '/knowledge-base/:id/destroy' do
    @revision = Revision.find(params[:id])
    authorize! @revision
    @revision.destroy!
    flash[:notice] = I18n.t('knowledge_base.destroyed')
    redirect url(:knowledge_base, :index)
  end

  get :approve, map: '/knowledge-base/:id/approve' do
    @revision = Revision.find(params[:id])
    authorize! @revision
    @revision.approve!
    flash[:notice] = I18n.t('knowledge_base.approved')
    redirect url(:knowledge_base, :show, id: @revision)
  end

end

Downthemall.controller :knowledge_base do
  KnowledgeBaseController.install_routes!(self)
end

