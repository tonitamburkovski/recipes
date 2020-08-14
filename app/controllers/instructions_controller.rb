class InstructionsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @instruction = @recipe.instructions.build
  end

  def create
    recipe = Recipe.find(params[:recipe_id])

    instruction = recipe.instructions.build(instruction_params)

    instruction.save
    redirect_to recipe
  end

  private

  def instruction_params
    params.require(:instruction).permit(:step, :instruction)
  end
end
