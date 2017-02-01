class TaskTime < ApplicationRecord
  # Relationships
  belongs_to :task, required: true

  # Validations
  validates :start_date, presence: true
end
