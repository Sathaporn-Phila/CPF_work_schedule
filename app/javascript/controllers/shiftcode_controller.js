import { Controller } from "stimulus"
export default class extends Controller {
    static values = { pagename: String }
    connect() {
        this.tableName = "งานถอนขน"
    }
    select_shiftcode(event) {
        this.table = document.querySelector("#" + this.tableName + "_c")
        this.val = event.currentTarget.value
        this.filter_element = document.querySelectorAll(`.time_${this.val}`)
        console.log(this.table.rows)
        Array.from(this.table.rows).forEach((each_row) => {
            each_row.style.display = "block";
            if (!(Array.from(this.filter_element).includes(each_row))) {
                each_row.style.display = "none";
            }
        })
    }
    set_table_from_page() {
        this.tableName = this.pagenameValue
    }

}