ENV['RACK_ENV'] = 'test'
require('capybara/rspec')
require('./app')
require('spec_helper')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('the recipe box app', type: :feature) do
  describe('add category') do
    it('allow a user to add a category') do
      visit('/')
      fill_in('name', with: 'Appetizers')
      click_button('Add')
      expect(page).to(have_content('Appetizers'))
    end
  end

  describe('edit category name') do
    it('allow a user to rename a category') do
      Category.create(name: 'Appetizers')
      visit('/')
      click_link('Edit')
      fill_in('name', with: 'Entrees')
      click_button('Update')
      expect(page).to(have_content('Entrees'))
    end
  end

  describe('delete category') do
    it('allow a user to delete a category') do
      Category.create(name: 'Appetizers')
      visit('/')
      click_link('Edit')
      click_button('Delete')
      expect(page).to_not(have_content('Appetizers'))
    end
  end
end
