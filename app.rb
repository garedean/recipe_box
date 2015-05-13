require("bundler/setup")
require('pry')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/') do
  @categories = Category.all
  erb(:categories)
end

post('/categories') do
  name = params.fetch("name")
  @object = Category.new(name: name)
  if @object.save()
    redirect to('/')
  else
    erb(:error)
  end
end

get('/categories/:id/edit') do
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  erb(:category_edit)
end

patch('/categories/:id') do
  id = params.fetch('id').to_i()
  name = params.fetch('name')
  Category.find(id).update(name: name)
  redirect to('/')
end

delete('/categories/:id') do
  id = params.fetch('id').to_i()
  Category.find(id).destroy()
  redirect to('/')
end

get('/categories/:id') do
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  @recipes = @category.recipes()
  erb(:category)
end

post('/categories/:id/recipes') do
  category = Category.find(params["id"].to_i)

  #category.recipes.push(recipe)
  @object = Recipe.new(name: params.fetch("name"), category_ids: [category.id])

  if @object.save()
    redirect to("/categories/#{params["id"]}")
  else
    erb(:errors)
  end
end

get('/categories/:category_id/recipes/:id') do
  category_id = params.fetch('category_id').to_i()
   id = params.fetch('id').to_i()
   @recipe = Recipe.find(id)
   @category = Category.find(category_id)
   @ingredients = @recipe.ingredients()
  erb(:recipe)
end

get '/categories/:category_id/recipes/:id/edit' do
  category_id = params.fetch('category_id').to_i()
  id = params.fetch('id').to_i()
  @recipe = Recipe.find(id)
  @category = Category.find(category_id)
  erb(:recipe_edit)
end

delete('/categories/:category_id/recipes/:id') do
  category_id = params.fetch('category_id').to_i()
  id = params.fetch('id').to_i()
  Recipe.find(id).destroy()
  redirect to('/')
end

patch '/categories/:category_id/recipes/:id' do

end

post('/categories/:category_id/recipes/:id/ingredients') do
  recipe = Recipe.find(params.fetch("id").to_i)
  #category.recipes.push(recipe)
  @object = Ingredient.new(name: params.fetch("name"), recipe_id: recipe.id)
  if @object.save()
    redirect back
  else
    erb(:errors)
  end
end

delete('/categories/:category_id/recipes/:recipe_id/ingredients/:id') do
  category_id = params.fetch('category_id').to_i()
  recipe_id = params.fetch('recipe_id').to_i()
  id = params.fetch('id').to_i()
  Ingredient.find(id).destroy()
  redirect to("/categories/#{category_id}/recipes/#{recipe_id}")
end
