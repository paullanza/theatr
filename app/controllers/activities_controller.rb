class ActivitiesController < ApplicationController
  def show
    @activity = Activity.find(params[:id])
    @user_response = UserResponse.new()
  end

  def index
    @activities = policy_scope(Activity)
  end
end
