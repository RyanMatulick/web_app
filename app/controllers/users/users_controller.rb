module Users
  class UsersController < ActionController::Base
    before_action :load_user
    respond_to :json

    attr_reader :user

    def index 
      render_response(user_detail, 200)
    end

    def show
      user_detail = {
        id: @user.id,
        name: @user.name,
        title: @user.title
      }
      render_response(user_detail, 200)
    end

    def create
      status = 200
      @user = create_user
      render_response({ id: @user.try(:id) }, status)
    end

    def update
      errors = {}
      begin
        ActiveRecord::Base.transaction do
          @user.update_attributes!(user_params)
        end
      rescue ActiveRecord::RecordInvalid => e
        errors = record_errors(e)
      end
      render_errors(errors)
    end

    private

    def load_user
      @user = User.find(permitted_params[:id])
    end

    def permitted_params
      params.permit(:id)
    end

    def render_response(payload, status)
      render json: payload, status: status
    end
  end
end
