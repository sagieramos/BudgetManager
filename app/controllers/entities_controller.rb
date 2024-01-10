class EntitiesController < ApplicationController
  before_action :set_entity, only: %i[show edit update destroy]

  def index
    @recent_entities = Entity.most_recent(current_user)
    @ancient_entities = Entity.most_ancient(current_user)
    @entities = Entity.all # Or whatever logic you have for all entities
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

    @entity.groups << Group.find(params[:entity][:group_id])

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
    @entity.destroy
    redirect_to entities_path, notice: 'Entity was successfully destroyed.'
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
    params.require(:entity).permit(:name, :amount)
  end
end
