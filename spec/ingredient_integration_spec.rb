ENV['RACK_ENV'] = 'test'
require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the recipe box app', type: :feature) do
  describe('add incredient functionality') do
    it('adds a new ingredient to a recipe') do
      category = Category.create(name: 'Appetizers')
      recipe = Recipe.new(name: 'Caviar on crackers', category_ids: category.id)
      recipe.save
      Ingredient.new(name: 'Caviar', recipe_id: recipe.id).save
      visit("/categories/#{category.id}/recipes/#{recipe.id}")
      fill_in('name', with: 'Caviar')
      click_button('Add')
      expect(page).to(have_content('Caviar'))
    end
  end

  # describe('delete recipe functionality') do
  #   it('deletes a recipe') do
  #     category = Category.create(name: 'Appetizers')
  #     Recipe.new(name: 'Caviar on crackers', category_ids: category.id).save
  #     visit("/categories/#{category.id}")
  #     click_link('Edit')
  #     click_button('Delete')
  #     expect(page).not_to(have_content('Peanut Butter'))
  #   end
  # end
  #
  # describe('edit recipe functionality') do
  #   it('edits a recipe') do
  #     category = Category.create(name: 'Appetizers')
  #     Recipe.new(name: 'Caviar on crackers', category_ids: category.id).save
  #     visit("/categories/#{category.id}")
  #     click_link('Edit')
  #     fill_in('name', with: "Caviar")
  #     click_button('Update')
  #     expect(page).not_to(have_content('Cavier on crackers'))
  #   end
  # end
end
