require('spec_helper')

describe(Ingredient) do
  describe('validations for input fields') do
    it('shows error page when ingredient name is not present') do
      ingredient = Ingredient.new(name: '')
      expect(ingredient.save).to(eq(false))
    end

  it('shows error page when ingredient name length is <= 2 ') do
    ingredient = Ingredient.new(name: 'r')
    expect(ingredient.save).to(eq(false))
  end

  it('shows error page when ingredient name length is >= 50') do
    ingredient = Ingredient.new(name: 'r'*(51))
    expect(ingredient.save).to(eq(false))
  end

  it('shows error page when ingredient name is not unique') do
    Ingredient.create(name: 'dinner')
    test_ing = Ingredient.new(name: 'dinner')
    expect(test_ing.save()).to(eq(false))
  end
end
end
