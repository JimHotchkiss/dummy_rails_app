class Project < ApplicationRecord
  has_many :project_categories
  has_many :categories, through: :project_categories
  belongs_to :user, optional: true

  accepts_nested_attributes_for :categories # need to write my own method for this

  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      category = Category.find_or_create_by(category_attribute)
      self.categories << category
    end
  end


end
