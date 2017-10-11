class Project < ApplicationRecord
  has_many :project_categories
  has_many :categories, through: :project_categories
  belongs_to :user, optional: true
  has_many :comments

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      if !category_attribute[:name].blank?
        category = Category.find_or_create_by(category_attribute)
        self.categories << category
      end
    end
  end


end
