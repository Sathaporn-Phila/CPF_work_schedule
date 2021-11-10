import consumer from "./consumer"

consumer.subscriptions.create({ channel: "ActualTimeChannel", room: "schedule room" },{
    connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to the room!");
    },
})