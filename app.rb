require('bundler/setup')
require('pry')
Bundler.require(:default)
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get('/reset') do
  reset_everything
  redirect to('/')
end

get('/recipes/top') do
  @recipes = Recipe.where('rating > 3').order(:rating)
  erb(:recipes)
end

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
  redirect back
end

delete('/categories/:id') do
  id = params.fetch('id').to_i()
  Category.find(id).destroy()
  redirect ("/")
end

get('/categories/:id') do
  id = params.fetch('id').to_i()
  @category = Category.find(id)
  @recipes = @category.recipes()
  erb(:category)
end

post('/categories/:id/recipes') do
  category = Category.find(params["id"].to_i)

  #category.recipes << recipe
  @object = Recipe.new(name: params.fetch("name"), category_ids: [category.id])

  if @object.save()
    redirect back
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
   @instructions = @recipe.instructions()
  erb(:recipe)
end

get('/categories/:category_id/recipes/:id/edit') do
  category_id = params.fetch('category_id').to_i()
  id = params.fetch('id').to_i()
  @recipe = Recipe.find(id)
  @category = Category.find(category_id)
  @categories = Category.all()
  @ingredients  = @recipe.ingredients
  @instructions = @recipe.instructions
  @categories_checked = @recipe.categories.ids
  erb(:recipe_edit)
end

delete('/categories/:category_id/recipes/:id') do
  category_id = params.fetch('category_id').to_i()
  id = params.fetch('id').to_i()
  Recipe.find(id).destroy()
  redirect ("/categories/#{category_id}")
end

patch('/categories/:category_id/recipes/:recipe_id') do
  recipe = Recipe.find(params.fetch("recipe_id").to_i)
  rating = params.fetch('rating', nil)
  name   = params.fetch('name', nil)
  categories = params.fetch('checkbox_values', nil)
  categories.map!(&:to_i)

  if name
    recipe.update(name: name)
  end

  if rating
    recipe.update(rating: rating.to_i)
  end

  if categories
    recipe.category_ids = categories
  end
#binding.pry
  category_id = params.fetch('category_id').to_i()

  redirect back if params.fetch("same_page", nil)

  redirect to("/categories/#{category_id}")

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
  redirect back
  #redirect to("/categories/#{category_id}/recipes/#{recipe_id}")
end

# INSTRUCTIONS
# -----------------------------------------------------------------------

post '/categories/:category_id/recipes/:recipe_id/instructions' do
  recipe = Recipe.find(params.fetch("recipe_id").to_i)

  recipe.instructions.create(description: params.fetch("description"))

  # ------Alternate syntaxes on creating associated objects-------

  #instruction = Instruction.new(description: params.fetch("description"), recipe_id: recipe.id)
  #instruction.save

  # instruction = Instruction.new(description: params.fetch("description"))
  # recipe.instructions << instruction

  redirect back
end

delete('/categories/:category_id/recipes/:recipe_id/instructions/:id') do
  category_id = params.fetch('category_id').to_i()
  recipe_id = params.fetch('recipe_id').to_i()
  id = params.fetch('id').to_i()
  Instruction.find(id).destroy()
  redirect back
  #redirect to("/categories/#{category_id}/recipes/#{recipe_id}")
end
