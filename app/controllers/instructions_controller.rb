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

  def destroy
    instruction = instruction.find(params[:id])
    instruction.destroy

    redirect_to instruction.article
  end

  private

  def instruction_params
    params.require(:instruction).permit(:step, :instruction)
  end
end
