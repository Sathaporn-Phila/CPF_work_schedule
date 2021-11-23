import consumer from "./consumer"
import $ from "jquery"
consumer.subscriptions.create({ channel: "ActualTimeChannel", room: "schedule_room" }, {
    connected() {
        // Called when the subscription is ready for use on the server
        console.log("Connected to the room!");
    },
    received(data) {
        if (data['role'] == "คนงานทั่วไป") {
            var type = '_c'
        }
        console.log(data)
        const sel = "#" + data['department'] + type;
        console.log(sel)
        const element = document.querySelector(sel);
        const elem = `<tr id=${data['name']}><td>` + data["name"] + '</td>' + '<td>' + data["time_in"] + '</td>' + '<td>' + data['time_out'] + '</td>' + `<td class=time_${data['shift_code']}>` + data['shift_code'] + '</td>' + '<td>' + data['department'] + '</td>' + '<td>' + data['ot_time'] + '</td>' + '</tr>'
        console.log(data['ot_time'])
        if (data["act"] == "show") {
            element.insertAdjacentHTML("beforeend", elem);
        } else {
            this.time_elem = document.querySelectorAll(`tr#${data['name']}`)
            this.time_elem[this.time_elem.length - 1].remove()
            element.insertAdjacentHTML("beforeend", elem);
        }
    }
})