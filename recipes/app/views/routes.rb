# frozen_string_literal: true

set :show_exceptions, :after_handler

error 400..499 do
  erb :not_found
end

error 500..599 do
  erb :something_wrong
end

before '/' do
  @fetch_result = Recipes::PaginationService.call
  if @fetch_result.success?
    @parsed_recipes = Recipes::FormatService.call(@fetch_result.value)
  else
    halt 500
  end
end

get '/' do
  if @parsed_recipes.success?
    @recipes = @parsed_recipes.value
    erb :index
  else
    500
  end
end

before '/:id' do |id|
  @find_result = Recipes::FindService.call(id)
  if @find_result.success?
    @parsed_recipe = Recipes::FormatService.call(@find_result.value)
  else
    halt 404
  end
end

get '/:id' do
  if @parsed_recipe.success?
    @recipe = @parsed_recipe.value
    erb :show
  else
    404
  end
end
