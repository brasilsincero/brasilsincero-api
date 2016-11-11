module RecordNotFoundHandler
  extend ActiveSupport::Concern

  included do
    rescue_from RecordNotFound do |exception|
      render json: { error: exception.message }, status: :not_found
    end
  end
end
