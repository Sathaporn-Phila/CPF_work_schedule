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
    static values = { param: Array, }
    connect() {
        console.log(this.paramValue)
        var calendarEl = document.querySelector('#calendar');
        this.calendar = new Calendar(calendarEl, {
            plugins: [dayGridPlugin, timeGridPlugin, listPlugin],
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next',
                center: 'title',
                right: 'today'
            },
            events: this.paramValue
                // events: [{ "title": "เวลาเข้า : 17:13:32", "start": "2021-11-20", "color": "green", "textColor": "black" }, { "title": "เวลาออก : 17:13:34", "start": "2021-11-20", "color": "red", "textColor": "black" }, { "title": "OT : 2.22", "start": "2021-11-20", "color": "orange", "textColor": "black" }]
        });
        this.calendar.render()
    }
}