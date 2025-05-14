class VehiclesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "vehicles_channel"
    vehicles = Vehicle.all.as_json
    ActionCable.server.broadcast("vehicles_channel", {
      action: "index",
      vehicles: vehicles
    })
  end

  def unsubscribed
  end

  private

  def broadcast_vehicles_list
    ActionCable.server.broadcast("vehicles_channel", {
      action: "index",
      vehicles: Vehicle.all.as_json
    })
  end
end
