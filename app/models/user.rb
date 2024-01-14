class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :entities, foreign_key: 'author_id', dependent: :destroy
  has_many :groups, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5 }, on: :create
  validates :email, presence: true, length: { minimum: 5 }, on: :create
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  validates :name, presence: true, length: { minimum: 5 }, allow_blank: { on: :update }
  validates :email, presence: true, length: { minimum: 5 }, allow_blank: { on: :update }
  validates :password, presence: true, length: { minimum: 6 }, allow_blank: { on: :update }

  def user_groups
    groups.where(user_id: id).order(created_at: :desc)
  end

  def user_entities
    entities.where(user_id: id).order(created_at: :desc)
  end

  def self.most_recent(user, limit = 5)
    where(id: user.id).order(created_at: :desc).limit(limit)
  end

  def self.most_ancient(user, limit = 5)
    where(id: user.id).order(created_at: :asc).limit(limit)
  end
end
