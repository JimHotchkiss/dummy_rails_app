class AddProjectIdColumnToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :project_id, :integer
  end
end
