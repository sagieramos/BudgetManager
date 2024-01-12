class EntitiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entity, only: %i[show edit update destroy]

  def index
    @recent_entities = Entity.most_recent(current_user).includes(:groups)
    @ancient_entities = Entity.most_ancient(current_user).includes(:groups)
  end

  def all(_index)
    @entities = Entity.all
  end

  def show; end

  def new
    @entity = Entity.new
  end

  def create
    @entity = Entity.new(entity_params.merge(author_id: current_user.id))

    @entity.groups << Group.find(params[:entity][:group_id]) if params[:entity][:group_id].present?

    if @entity.save
      redirect_to @entity, notice: 'Entity was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @entity.update(entity_params)
      redirect_to @entity, notice: 'Entity was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @entity = Entity.find(params[:id])
    if @entity.destroy
      redirect_to entities_path, notice: 'Entity was successfully destroyed.'
    else
      flash[:alert] = 'Error destroying entity.'
      render :show
    end
  end

  def most_recent
    @recent_entities = Entity.most_recent(current_user)
  end

  def most_ancient
    @ancient_entities = Entity.most_ancient(current_user)
  end

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount, group_ids: [])
  end
end
