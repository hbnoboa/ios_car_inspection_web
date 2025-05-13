class VehiclesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "vehicles_channel"
    broadcast_vehicles_list
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def broadcast_vehicles_list
    vehicles = Vehicle.where(done: 'yes').where(:updated_at.ne => nil).order(updated_at: :desc)
    ActionCable.server.broadcast("vehicles_channel", {
      action: "index",
      vehicles: vehicles.as_json
    })
  end
end
  