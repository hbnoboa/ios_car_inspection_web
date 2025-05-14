class VehiclesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "vehicles_channel"
    broadcast_vehicles_list
  end

  def unsubscribed
  end

  private

  def broadcast_vehicles_list
    vehicles = Vehicle.where(done: 'yes')
    ActionCable.server.broadcast("vehicles_channel", {
      action: "index",
      vehicles: vehicles.as_json
    })
  end
end
