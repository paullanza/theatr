class UserResponsesController < ApplicationController
  before_action :set_activity, only: [:create, :update]
  skip_before_action :verify_authenticity_token, only: [:create]


  def create

   @activity_questions.each do |question|
    @user_response = UserResponse.new(user: current_user, activity: @activity)
   end



    authorize @user_response
  end

  def update
    @user_response = UserResponse.find(params[:id])
    @user = @user_response.user
    @user_response.update(user_response_params)
    if @user_response.save!
      redirect_to results_path(@user, @activity)
    else
      render 'activities/results', status: :unprocessable_entity
    end
    authorize @user_response
  end

  private

  def user_response_params
    params.require(:user_response).permit(:text, :activity_question_id)
  end

  def set_activity
    @activity_question = ActivityQuestion.find(params[:activity_question_id])
    @activity = Activity.find(activity_question.activity.id)
  end
end
