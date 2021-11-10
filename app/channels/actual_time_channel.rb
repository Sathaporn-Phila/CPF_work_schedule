class ActualTimeChannel < ApplicationCable::Channel
  def subscribed
     stream_from "actual_time_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
