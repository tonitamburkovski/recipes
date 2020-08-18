class RecipesController < ApplicationController
  skip_before_action :require_login, only: [:index, :show]
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @recipes = Recipe.all
  end

  def show

  end

  def new
    @recipe = Recipe.new
    10.times { @recipe.ingredients.build }
    10.times { @recipe.instructions.build }
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def edit

  end

  def update

    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    @recipe.destroy
    redirect_to recipes_path
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def correct_user
    unless equal_with_current_user?(@recipe.user)
      flash[:danger] = 'Wrong User'
      redirect_to(root_path)
    end
  end

  def recipe_params
    params.require(:recipe).permit(:title, :description,
      ingredients_attributes:[:id, :qty, :unit, :ingredient],
      instructions_attributes:[:id, :step, :instruction])
  end
end
