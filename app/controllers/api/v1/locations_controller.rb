class Api::V1::LocationsController <  ApiController
  def index
  end

  def create
    @location = Location.new(event_params)

    # probably a more accurate way to save this but good for now
    @location.saved_at = Time.zone.now

    if @location.save
      render
    else
      render json: {
        message: 'Validation Failed',
        errors: @location.errors.full_messages
      }, status: 422
    end
  end

  private

    def event_params
      {
        latitude: params[:latitude],
        longitude: params[:longitude],
        created_at: params[:createdAt],
        unique_id: params[:uniqueId],
        idfa: params[:idfa]
      }

    end
end
