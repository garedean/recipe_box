class Recipe < ActiveRecord::Base
  has_many(:ingredients)
  has_many(:instructions)
  has_and_belongs_to_many(:categories)
  validates(:name, {:presence => true, :length => {:minimum => 2, :maximum => 50}})
  validates_uniqueness_of(:name)

end
