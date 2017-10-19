# Controller for creating and managing annotations
class AnnotationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!, only: :create

  def create
    annotation = Annotation.new(annotation_params)
    if annotation.save
      render json: { success: 'annotation saved' }, status: 200
    else
      render json: { failure: annotation.errors }, status: 400
    end
  end

  private

  def annotation_params
    params.require(:annotations_form).permit(:text, :citation)
  end
end
