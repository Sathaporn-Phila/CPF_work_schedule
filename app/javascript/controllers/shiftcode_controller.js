import { Controller } from "stimulus"
export default class extends Controller {
    connect() {

    }
    select_shiftcode() {
        console.log("Hello from Shiftcode controller")
        console.log(this)
    }
}