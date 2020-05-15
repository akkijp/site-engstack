class Post < ApplicationRecord
    has_many :tasks, dependent: :destroy
    has_many :categories, through: :tasks
end
