json.extract! vehicle, :id, :location, :type, :chassis, :nonconformity, :model, :status, :ship, :situation, :observations, :etChassisImage, :profileImage, :frontImage, :backImage, :rightSideImage, :leftSideImage, :created_at, :updated_at

[:etChassisImage, :profileImage, :frontImage, :backImage, :rightSideImage, :leftSideImage].each do |image_attr|
  if vehicle.send(image_attr).present?
    data_uri = "data:#{vehicle.send(image_attr).file.content_type};base64,#{Base64.strict_encode64(vehicle.send(image_attr).file.read)}"
    json.set! "#{image_attr}_data_uri", data_uri
  end
end

json.url vehicle_url(vehicle, format: :json)