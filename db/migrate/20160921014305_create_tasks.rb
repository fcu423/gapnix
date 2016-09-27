class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.string :description
      t.integer :project_id, null: false
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
