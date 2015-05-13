class Category < ActiveRecord::Base
  has_and_belongs_to_many(:recipes)
  validates(:name, {:presence => true, :length => {:minimum => 2, :maximum => 50}})
  validates_uniqueness_of(:name)
end
