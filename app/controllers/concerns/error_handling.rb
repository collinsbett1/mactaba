module ErrorHandling
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render_error(:not_found, "Resource not found")
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render_error(:unprocessable_entity, e.record.errors.full_messages)
    end
  end

  private

  def render_error(status, message)
    respond_to do |format|
      format.html { 
        flash[:alert] = message
        redirect_back(fallback_location: root_path)
      }
      format.json { render json: { error: message }, status: status }
    end
  end
end 