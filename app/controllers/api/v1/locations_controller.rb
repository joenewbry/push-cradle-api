class Api::V1::LocationsController <  ApiController
  def index
  end

  def create
    locations = params[:locations]
    if locations && locations.count > 0
      locations.each do |location|
        @location = Location.new(event_params(location))

        # probably a more accurate way to save this but good for now
        @location.saved_at = Time.zone.now
        if not @location.save
          render json: {
            message: 'Validation Failed',
            errors: @location.errors.full_messages
          }, status: 422
          return
        end
      end

      render json: {
        status: "success",
        message: "All locations saved"
      }, status: 200
    else
      render json: {
        message: 'No Locations Found'
      }, status: 422
    end

  end

  private

    def event_params(jsonBlob)
      {
        latitude: jsonBlob[:latitude],
        longitude: jsonBlob[:longitude],
        created_at: jsonBlob[:createdAt],
        unique_id: jsonBlob[:uniqueId],
        idfa: params[:idfa]
      }

    end
end
