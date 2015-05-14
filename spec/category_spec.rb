require('spec_helper')

describe(Category) do
  # it('has many recipes') do
  #   category = Category.create(name: 'Appetizers')
  #   recipe1 = Recipe.create(name: 'Caviar on crackers', category_ids: [category.id])
  #   recipe2 = Recipe.create(name: 'Smoked salmon', category_ids: [category.id])
  #   expect(category.recipes).to(eq([recipe1, recipe2]))
  # end

  it { should have_and_belong_to_many(:recipes) }

  it('validates presence of name') do
    category = Category.new(name: '')
    expect(category.save).to(eq(false))
  end

  it('validates name is 2 or more characters') do
    category = Category.new(name: 'r')
    expect(category.save).to(eq(false))
  end

  it('validates name is 50 or fewer characters') do
    category = Category.new(name: 'r'*(51))
    expect(category.save).to(eq(false))
  end

  it('validates name is unique') do
    Category.create(name: 'dinner')
    test_cat = Category.new(name: 'dinner')
    expect(test_cat.save()).to(eq(false))
  end
end
