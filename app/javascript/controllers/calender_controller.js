// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import listPlugin from '@fullcalendar/list';
export default class extends Controller {
    static targets = ["event_do"]
    connect() {
        var calendarEl = document.querySelector('#calendar');
        this.calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin, timeGridPlugin, listPlugin],
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,listWeek'
            },
            events: [{
                title: "เข้างาน",
                color: "green",
                start: "2021-11-19",
                textColor: "black"
            }, {
                title: "ออกงาน",
                color: "red",
                start: "2021-11-19",
                textColor: "black"
            }, {
                title: "OT",
                color: "orange",
                start: "2021-11-19",
                textColor: "black"
            }]
        });
        this.calendar.render()
    }
}