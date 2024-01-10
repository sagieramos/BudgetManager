class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :entities, foreign_key: 'author_id'
  has_many :groups

  before_destroy :delete_associated_group_entities

  validates :name, presence: true, length: { minimum: 5 }
  validates :email, presence: true, length: { minimum: 5 }
  validates :password, presence: true, length: { minimum: 6 }

  def user_groups
    groups.where(user_id: id).order(created_at: :desc)
  end

  def user_entities
    entities.where(user_id: id).order(created_at: :desc)
  end

  def self.most_recent(user, limit = 5)
    where(user:).order(created_at: :desc).limit(limit)
  end

  def self.most_ancient(user, limit = 5)
    where(user:).order(created_at: :asc).limit(limit)
  end

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
