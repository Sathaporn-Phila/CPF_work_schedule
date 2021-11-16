import consumer from "./consumer"
require("jquery")
consumer.subscriptions.create({ channel: "ActualTimeChannel", room: "schedule room" }, {
    connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to the room!");
    },
    received(data) {
        if(data['role'] == "หัวหน้าแผนก"){
            var type = '_m'
        }else if(data['role'] == "คนงานทั่วไป"){
            var type = "_c"
        }
        const sel = "#" + data['department'] + type;
        const el = '#' + data['name'];
        const el1 = document.querySelector(el);
        const element = document.querySelector(sel);
        const elem = '<tr><td>' + data["name"] + '</td>' + '<td>' + data["time_in"] + '</td>' + '<td>' + data['time_out'] + '</td>'+ '<td>' + data['role'] + '</td>' + '<td>' + data['department'] + '</td>' + '</tr>';
       
        if (data["act"] == "show") {
            element.insertAdjacentHTML("beforeend", elem);
        } else {
            el1.remove()
            element.insertAdjacentHTML("beforeend", elem);
        }
    }
})