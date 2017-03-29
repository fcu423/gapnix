class AddColumnToTask < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :stored_manually, :boolean, default: false
  end
end
