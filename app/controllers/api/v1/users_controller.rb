module Api::V1
  class UsersController < ApiController
    def update
      if current_user.update(users_params)
        head :ok
      else
        render json: current_user.errors
      end
    end

    def users_params
      params.permit(:os_id)
    end
  end
end
