class Group < ApplicationRecord
  belongs_to :author
  belongs_to :entity
end
