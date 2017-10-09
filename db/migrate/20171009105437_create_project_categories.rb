class CreateProjectCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :project_categories do |t|
      t.integer :project_id
      t.integer :category_id
    end
  end
end
