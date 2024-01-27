module Api::V1
  class PartsController < ApiController
    def index
      render json: Part.all
    end
  end
end
