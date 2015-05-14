class Instruction < ActiveRecord::Base
  belongs_to(:recipe)
  validates(:description, {:presence => true, :length => {:minimum => 2, :maximum => 500}})

end
