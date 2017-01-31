class Category < ApplicationRecord
  acts_as_paranoid

  has_many :tasks, dependent: :destroy
  belongs_to :project

  validates :name, presence: true
end