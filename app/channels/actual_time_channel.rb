class ActualTimeChannel < ApplicationCable::Channel
  def subscribed
     stream_from "actual_time_channel#{params[:room]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
  def receive(data)
    ActionCable.server.broadcast("actual_time_channel#{params[:room]}", data)
  end
end
