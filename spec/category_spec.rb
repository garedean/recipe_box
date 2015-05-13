require('spec_helper')

describe(Category) do
  describe('validations for input fields, #save') do
    it('shows error page when category name is not present') do
      category = Category.new(name: '')
      expect(category.save).to(eq(false))
    end

    it('returns false when category name length is <= 2 ') do
      category = Category.new(name: 'r')
      expect(category.save).to(eq(false))
    end

    it('returns false when category name length is >= 50') do
      category = Category.new(name: 'r'*(51))
      expect(category.save).to(eq(false))
    end

    it('returns false when category name is not unique') do
      Category.create(name: 'dinner')
      test_cat = Category.new(name: 'dinner')
      expect(test_cat.save()).to(eq(false))
    end
  end
end
