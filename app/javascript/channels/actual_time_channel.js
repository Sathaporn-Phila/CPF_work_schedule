import consumer from "./consumer"
require("jquery")
consumer.subscriptions.create({ channel: "ActualTimeChannel", room: "schedule room" },{
    connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to the room!");
    },
    received(data) {
        const element = document.querySelector("#time_object")
        const elem = '<tr><td>'+ data["name"] +'</td>'+'<td>'+ data["time_attendance"] +'</td></tr>'
        element.insertAdjacentHTML("beforeend", elem)
    }
})