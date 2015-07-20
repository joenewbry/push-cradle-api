class DevicesController < ApplicationController

  # list out all the devices that we have
  def index
    @devices = Device.all()
  end

  # list out the locations that we have for that device
  def show
    @device = Device.find(params[:id])
    @locations = Location.where(idfa: @device.idfa)
  end
end
