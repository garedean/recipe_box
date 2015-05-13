ENV['RACK_ENV'] = 'test'

require("bundler/setup")
Bundler.require(:default, :test)

Dir[File.dirname(__FILE__) + '/../lib/*.rb'].each { |file| require file }

RSpec.configure do |config|
  config.before(:each) do
    #optionally do something before each test
  end
  config.after(:each) do
    #optionally do something after each test
    Category.all().each do |category|
      category.destroy()
    end
    Recipe.all().each do |recipe|
      recipe.destroy()
    end
    Ingredient.all().each do |ingredient|
      ingredient.destroy()
    end
  end
end
