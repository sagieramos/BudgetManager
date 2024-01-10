class EntitiesController < ApplicationController
  def index
    @groups = current_user.groups
    @entities = @groups.map(&:entities).flatten
  end

  def new
    @entity = Entity.new
  end

  def create
    @entity = Entity.new(entity_params)
    @groups = current_user.groups

    if !@entity.valid?
      flash.now[:notice] = 'Kindly create a valid entity by filling all information'
      render :new, status: :unprocessable_entity
    elsif @groups.empty?
      flash.now[:notice] = 'Minimum of 1 group is needed'
      render :new, status: :unprocessable_entity
    elsif @entity.save
      @groups.each do |group|
        group.entities << @entity
      end
      flash.now[:notice] = 'Entity was successfully created'
      redirect_to root_path
    else
      flash.now[:notice] = 'An unexpected error occurred'
      render :new, status: :unprocessable_entity
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :amount, group_ids: []).merge(user: current_user)
  end
end
