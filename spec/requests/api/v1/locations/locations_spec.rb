require 'spec_helper'

describe 'POST /v1/locations' do
  it 'saves the lat, long, created_at, device_token, object_id' do
    date = Time.zone.now
    device_token = '11231231lkjlkj'

    json = {"idfa": '11231231lkjlkj',
      "locations": [{
        latitude: '1.0',
        longitude: '1.0',
        createdAt: date,
        uniqueId: "AE976199-516A-4832-BD1F-3FAAAE34F85F"
      }]
    }


    post '/v1/locations', json
    set_headers(device_token)

    location = Location.last
    expect(response_json).to eq({ 'status' => 'success', "message"=>"All locations saved" })
    expect(location.latitude).to eq 1.0
    expect(location.longitude).to eq 1.0
    expect(location.created_at.to_i).to eq date.to_i
    expect(location.unique_id).to eq "AE976199-516A-4832-BD1F-3FAAAE34F85F"
    expect(location.idfa).to eq device_token

  end
end
