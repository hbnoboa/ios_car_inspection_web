class VehiclesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "vehicles_channel"
    vehicles = Vehicle.all.as_json
    broadcast_vehicles_list
  end

  def unsubscribed
  end

  private

  def broadcast_vehicles_list
    ActionCable.server.broadcast("vehicles_channel", {
      type: "index",
      message: Vehicle.all.as_json
    })
  end
end
