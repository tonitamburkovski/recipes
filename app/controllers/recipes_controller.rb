class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    session_notice(:danger, 'You must be logged in!') unless logged_in?
    @recipe = Recipe.new
    1.times { @recipe.ingredients.build }
    1.times { @recipe.instructions.build }
  end

  def create
    unless logged_in?
      session_notice(:danger, 'You must be logged in!', login_path) and return
    end

    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit
    session_notice(:danger, 'You must be logged in!') unless logged_in?

    @recipe = Recipe.find(params[:id])

    if logged_in?
      session_notice(:danger, 'Wrong User') unless equal_with_current_user?(@recipe.user)
    end
  end

  def update
    unless logged_in?
      session_notice(:danger, 'You must be logged in!', login_path) and return
    end

    @recipe = Recipe.find(params[:id])

    if equal_with_current_user?(@recipe.user)
      if @recipe.update(recipe_params)
        redirect_to @recipe
      else
        render 'edit'
      end
    else
      session_notice(:danger, 'Wrong User') and return
    end
  end

  def destroy
    unless logged_in?
      session_notice(:danger, 'You must be logged in!', login_path) and return
    end

    recipe = Recipe.find(params[:id])

    if equal_with_current_user?(recipe.user)
      recipe.destroy
      redirect_to recipes_path
    else
      session_notice(:danger, 'Wrong User')
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :description,
      ingredients_attributes:[:id, :qty, :unit, :ingredient],
      instructions_attributes:[:id, :step, :instruction])
  end
end
