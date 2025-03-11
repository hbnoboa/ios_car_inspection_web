json.extract! vehicle, :id, :location, :type, :chassis, :nonconformity, :model, :status, :ship, :situation, :observations, :etChassisImage, :profileImage, :frontImage, :backImage, :rightSideImage, :leftSideImage, :created_at, :updated_at

json.url vehicle_url(vehicle, format: :json)