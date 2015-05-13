class Ingredient < ActiveRecord::Base
  belongs_to(:recipe)
  validates(:name, {:presence => true, :length => {:minimum => 2, :maximum => 50}})
  validates_uniqueness_of(:name)

end
