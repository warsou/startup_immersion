class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :situation_id, :formation, :user_id, :description, :linked_in_url, :newsletter_id)
    end

    def is_right_user?
      @user = User.find(params[:id])
      unless @user.id == current_user.id
        flash[:danger] = 'This is not your account'
        redirect_to user_path(current_user)
      end
    end
end
