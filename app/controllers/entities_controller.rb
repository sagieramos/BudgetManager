class EntitiesController < ApplicationController
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    @entities = Entity.all
  end

  def show
  end

  def new
    @entity = Entity.new
  end

  def create
    @entity = Entity.new(entity_params)

    if @entity.save
      redirect_to @entity, notice: 'Entity was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

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

  private

  def set_entity
    @entity = Entity.find(params[:id])
  end

  def entity_params
    params.require(:entity).permit(:name, :amount)
  end
end
