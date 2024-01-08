class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :entities, dependent: :destroy
  has_many :groups, dependent: :destroy

  before_destroy :delete_associated_group_entities

  private

  def delete_associated_group_entities
    groups.each do |group|
      group.group_entities.destroy_all
    end

    entities.each do |entity|
      entity.group_entities.destroy_all
    end
  end
end
