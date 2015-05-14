class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:name, {:presence => true, :length => {:minimum => 2, :maximum => 50}})
  validates_uniqueness_of(:name)
end

def reset_everything
  Category.all().each do |category|
    category.destroy()
  end
  Recipe.all().each do |recipe|
    recipe.destroy()
  end
  Ingredient.all().each do |ingredient|
    ingredient.destroy()
  end
end
