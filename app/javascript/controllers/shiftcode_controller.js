import { Controller } from "stimulus"
export default class extends Controller {
    connect() {

    }
    select_shiftcode(event) {
        this.val = event.currentTarget.value
        this.filter_element = new Array(...this.element.querySelectorAll(`.${this.val}`))
        console.log(this.filter_element)
    }
}