// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["count"];
  connect() {
    this.setCount();
  }

  checkAll() {
    this.setAllCheckboxes(true);
    this.setCount();
  }

  checkNone() {
    this.setAllCheckboxes(false);
    this.setCount();
  }

  onChecked() {
    this.setCount();
  }
  setOvertime(event){
    this.all_select_tag.forEach((el)=>{
      const select_tag = el;
      select_tag.value = event.currentTarget.value;
    })
  }
  setAllCheckboxes(checked) {
    this.checkboxes.forEach((el) => {
      const checkbox = el;
      if (!checkbox.disabled) {
          checkbox.checked = checked;  
      }
    });
  }

  setCount() {
    if (this.hasCountTarget) {
      const count = this.selectedCheckboxes.length;
      this.countTarget.innerHTML = `${count} selected`;
    }
  }
  setStatusSelectTag(event){
    const item = event.currentTarget
    const select_current_tag = new Array(...this.element.querySelector(`select#${item.id}.ot`))
    this.is_select_tag_enable(select_current_tag,item.checked)
  }
  get selectedCheckboxes() {
    return this.checkboxes.filter((c) => c.checked);
  }
  is_select_tag_enable(tag,checkbox_current){
    const some_tag = tag
    if(checkbox_current.checked){
      some_tag.forEach((el)=>{
        const select_tag = el;
        
      })
    }
    else{
      some_tag.disabled = true
    }
  }
  get checkboxes() {
    return new Array(...this.element.querySelectorAll("input[type=checkbox]"));
  }
  get all_select_tag(){
    return new Array(...this.element.querySelectorAll('.ot'))
  }

}
