require('spec_helper')

describe(Ingredient) do

  it { should belong_to(:recipe) }

  it('validates presence of name') do
    ingredient = Ingredient.new(name: '')
    expect(ingredient.save).to(eq(false))
  end

  it('validates length of name is 2 or more characters') do
    ingredient = Ingredient.new(name: 'r')
    expect(ingredient.save).to(eq(false))
  end

  it('validates lengthof name is 50 or fewer characters') do
    ingredient = Ingredient.new(name: 'r'*(51))
    expect(ingredient.save).to(eq(false))
  end

  it('validates name is unique') do
    Ingredient.create(name: 'dinner')
    test_ing = Ingredient.new(name: 'dinner')
    expect(test_ing.save()).to(eq(false))
  end
end
