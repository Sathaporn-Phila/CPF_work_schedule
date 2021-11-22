import { Controller } from "stimulus"
export default class extends Controller {
    static targets = ["actualCount","planCount"]
    static values = { pagename: String }
    connect() {
        this.tableName = "งานถอนขน"
    }
    select_shiftcode(event) {
        this.actual_count = 0
        this.plan_count = 0
        this.table = document.querySelector("#" + this.tableName + "_c")
        this.planTable = document.querySelector("#" + this.tableName + "_p")
        this.val = event.currentTarget.value
        //actual time
        Array.from(this.table.rows).forEach((each_row) => {
            each_row.style.display = "table-row";
            this.row_with_time_select = each_row.querySelectorAll(`td.time_${this.val}`)
            if (this.row_with_time_select.length == 0){
                each_row.style.display = "none";
            }
            else{
                this.actual_count += 1
            }
        })
        this.actualCountTarget.textContent = this.actual_count
        //plan time
        Array.from(this.table.rows).forEach((each_row) => {
            this.plan_row_with_time_select = each_row.querySelectorAll(`td.plan_${this.val}`)
            if(this.plan_row_with_time_select.length>0){
                this.plan_count += 1
            }
        })
        this.planCountTarget.textContent = this.plan_count
    }
    set_table_from_page() {
        this.tableName = this.pagenameValue
    }

}