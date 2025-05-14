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
    Rails.logger.info "Broadcasting vehicles list..."
    vehicles = Vehicle.where(done: 'yes').where.not(updated_at: nil).order(updated_at: :desc)
    Rails.logger.info "Vehicles to broadcast: #{vehicles.as_json}"
    ActionCable.server.broadcast("vehicles_channel", {
      action: "index",
      vehicles: vehicles.as_json
    })
  end
end
  