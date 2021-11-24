import { Controller } from "stimulus"
import $ from "jquery"
export default class extends Controller {
    static targets = ["actualCount", "planCount"]
    static values = { pagename: String, factory: String }
    connect() {
        /*if (this.pagenameValue == "งานถอนขน") {
            this.tableName = "งานถอนขน";
        } else if (this.pagenameValue == "งานไก่ตกราว") {
            this.tableName = "งานไก่ตกราว";
        } else if (this.pagenameValue == "งานเชือดไก่") {
            this.tableName = "งานเชือดไก่";
        } else {
            this.tableName = "งานจัดเก็บและจ่ายสินค้าแช่แข็ง";
        }*/
        this.tableName = "งานถอนขน"
    }
    async select_shiftcode(event) {
        this.actual_count = 0
        this.plan_count = 0
        this.table = document.querySelector("#" + this.tableName + "_c")
        this.planTable = document.querySelector("#" + this.tableName + "_p")
        this.val = event.currentTarget.value
            //actual time
        Array.from(this.table.rows).forEach((each_row) => {
            each_row.style.display = "table-row";
            this.row_with_time_select = each_row.querySelectorAll(`td.time_${this.val}`)
            if (this.row_with_time_select.length == 0) {
                each_row.style.display = "none";
            }
        })
        this.actual_count = await this.retrieve_num_person()
        this.actualCountTarget.textContent = this.actual_count.message
            //plan time
        Array.from(this.table.rows).forEach((each_row) => {
            this.plan_row_with_time_select = each_row.querySelectorAll(`td.plan_${this.val}`)
            if (this.plan_row_with_time_select.length > 0) {
                this.plan_count += 1
            }
        });
        this.planCountTarget.textContent = this.plan_count
    }
    retrieve_num_person() {
        return $.ajax({
            type: "get",
            url: "/num_user",
            data: { 'factory': document.querySelector('#โรงงาน').innerHTML, 'department': this.tableName, 'code_name': this.val },
            success: function(response) {

            },
        });
    }

}