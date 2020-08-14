class IngredientsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build
  end

  def create

    @recipe = Recipe.find(params[:recipe_id])
    @ingredient = @recipe.ingredients.build(ingredient_params)

    if @ingredient.save
      redirect_to @recipe
    else
      render :new
    end
  end

  def destroy
    ingredient = ingredient.find(params[:id])
    ingredient.destroy

    redirect_to ingredient.article
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:qty, :unit, :ingredient)
  end
end
