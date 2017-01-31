class Project < ApplicationRecord
  acts_as_paranoid

  has_many :tasks, dependent: :destroy
  has_many :categories, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
end
