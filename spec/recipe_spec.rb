require('spec_helper')

describe(Recipe) do
  it('has many categories') do
    recipe = Recipe.create(name: 'Caviar on crackers', category_ids: [category.id])
    category1 = Category.create(name: 'Appetizers', recipe_ids: [recipe.id])
    category2 = Category.create(name: 'Appetizers', recipe_ids: [recipe.id])
    expect(recipe.categories).to(eq([category1, category2]))
  end

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
