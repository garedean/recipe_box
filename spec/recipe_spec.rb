require('spec_helper')

describe(Recipe) do
  # it('has many categories') do
  #   recipe = Recipe.create(name: 'Caviar on crackers')
  #   category1 = Category.create(name: 'Dinner', recipe_ids: [recipe.id])
  #   category2 = Category.create(name: 'Brunch', recipe_ids: [recipe.id])
  #   expect(recipe.categories).to(eq([category1, category2]))
  # end

  it { should have_and_belong_to_many(:categories) }
  it { should have_many(:ingredients) }

  it('validates presence of name') do
    recipe = Recipe.new(name: '')
    expect(recipe.save).to(eq(false))
  end

  it('validates name is 2 or more characters') do
    recipe = Recipe.new(name: 'r')
    expect(recipe.save).to(eq(false))
  end

  it('validates name is 50 or fewer characters') do
    recipe = Recipe.new(name: 'r'*(51))
    expect(recipe.save).to(eq(false))
  end

  it('validates name is unique') do
    Recipe.create(name: 'dinner')
    test_rec = Recipe.new(name: 'dinner')
    expect(test_rec.save()).to(eq(false))
  end
end
