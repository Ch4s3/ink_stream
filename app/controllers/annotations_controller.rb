# Controller for creating and managing annotations
class AnnotationsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  before_action :authenticate_user!, only: :create

  def create
    article_id = Article.select(:id).find_by(uuid: article_and_user[:article_uuid]).id
    user_id = article_and_user[:user_id].to_i
    annotation = Annotation.new(annotation_params.merge(user_id: user_id, article_id: article_id))
    if annotation.save
      render json: { success: 'annotation saved' }, status: 201
    else
      render json: { failure: annotation.errors }, status: 400
    end
  end

  private

  def article_and_user
    params.require(:annotations_form).permit(:user_id, :article_uuid)
  end

  def annotation_params
    params.require(:annotations_form)
          .permit(:text,
                  :citation, :start_char, :end_char,
                  :selected_text)
  end
end
