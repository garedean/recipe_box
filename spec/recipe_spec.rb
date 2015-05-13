require('spec_helper')

describe(Recipe) do
  describe('validations for input fields, #save') do
    it('returns false when recipe name is not present') do
      recipe = Recipe.new(name: '')
      expect(recipe.save).to(eq(false))
    end

    it('returns false  when recipe name length is <= 2 ') do
      recipe = Recipe.new(name: 'r')
      expect(recipe.save).to(eq(false))
    end

    it('returns false  when recipe name length is >= 50') do
      recipe = Recipe.new(name: 'r'*(51))
      expect(recipe.save).to(eq(false))
    end

    it('returns false  when recipe name is not unique') do
      Recipe.create(name: 'dinner')
      test_rec = Recipe.new(name: 'dinner')
      expect(test_rec.save()).to(eq(false))
    end
  end
end
