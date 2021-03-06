require "bundler/setup"
Bundler.require :default
Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get "/" do
  erb :index
end

get "/recipes" do
  @recipes = Recipe.all
  erb :recipes
end

post "/recipes" do
  name = params['name']
  instructions = params['instructions']
  rating = params['rating'].to_i
  Recipe.create({name: name, instructions: instructions, rating: rating})
  redirect "/recipes"
end

get "/recipes/:id" do
  id = params["id"].to_i
  @recipe = Recipe.find(id)
  @list_ingredients = Ingredient.all
  erb :recipe
end

get "/tags" do
  @tags = Tag.all
  erb :tags
end

post "/tags" do
  category = params["category"]
  Tag.create({category: category})
  redirect "/tags"
end

get "/tags/:id" do
  id = params["id"].to_i
  @tag = Tag.find(id)
  erb :tag
end

get "/ingredients" do
  @ingredients = Ingredient.all
  erb :ingredients
end

post "/ingredients" do
  item = params["item"]
  ingredient = Ingredient.create({item: item})
  if ingredient.save
    redirect "/ingredients"
  else
    erb :errors
  end
end

get "/ingredients/:id" do
  id = params["id"]
  @ingredient = Ingredient.find(id)
  erb :ingredient
end
