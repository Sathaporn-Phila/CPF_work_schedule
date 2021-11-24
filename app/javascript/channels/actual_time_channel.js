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
        this.check_shift_code(data)
        this.show_or_delete_data_row(data, type)
    },
    check_shift_code(data) {
        this.select_code = $(`#shift_code_${data['department']}`)[0].value
        if (this.select_code == data['shift_code'] || this.select_code == null) {
            this.elem = `<tr id=${data['name']} style="display:table-row;"><td>` + data["name"] + '</td>' + '<td>' + data["time_in"] + '</td>' + '<td>' + data['time_out'] + '</td>' + `<td class=time_${data['shift_code']}>` + data['shift_code'] + '</td>' + '<td>' + data['department'] + '</td>' + '<td>' + data['ot_time'] + '</td>' + '</tr>'
        } else {
            this.elem = `<tr id=${data['name']} style="display:none;"><td>` + data["name"] + '</td>' + '<td>' + data["time_in"] + '</td>' + '<td>' + data['time_out'] + '</td>' + `<td class=time_${data['shift_code']}>` + data['shift_code'] + '</td>' + '<td>' + data['department'] + '</td>' + '<td>' + data['ot_time'] + '</td>' + '</tr>'
        }
    },
    show_or_delete_data_row(data, type) {
        const sel = "#" + data['department'] + type;
        const element = document.querySelector(sel);

        if (data["act"] == "show") {
            element.insertAdjacentHTML("beforeend", this.elem);
            this.num_people = Number($('#โรงงาน')[0].innerHTML) + 1
            $('#โรงงาน')[0].innerHTML = this.num_people
        } else {
            this.num_people = Number($('#โรงงาน')[0].innerHTML) - 1
            $('#โรงงาน')[0].innerHTML = this.num_people
            this.time_elem = document.querySelectorAll(`tr#${data['name']}`)
            this.time_elem[this.time_elem.length - 1].remove()
            element.insertAdjacentHTML("beforeend", this.elem);
        }
    }
})