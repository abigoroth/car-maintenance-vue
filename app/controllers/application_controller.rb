class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include Pagy::Backend

  after_action { pagy_headers_merge(@pagy) if @pagy }

  def website
    render template: 'layouts/website'
  end

  def panel
    return redirect_to '/login' unless user_signed_in?

    render template: 'layouts/panel'
  end

  def check_auth
    head :forbidden unless user_signed_in?
  end
end
