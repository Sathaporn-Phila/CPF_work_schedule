// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { variationPlacements } from "@popperjs/core";
import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["count"];
  connect() {
    this.setCount();
  }

  checkAll() {
    this.setAllCheckboxes(true);
    this.setCount();
    this.select_tag_is_activated(this.all_select_tag,true);
  }

  checkNone() {
    this.setAllCheckboxes(false);
    this.setCount();
    this.select_tag_is_activated(this.all_select_tag,false);
  }

  onChecked() {
    this.setCount();
  }
  setOvertime(event){
    this.all_select_tag.forEach((el)=>{
      const select_tag = el;
      if(select_tag.value.includes("[")){
        select_tag.selectedIndex = event.currentTarget.selectedIndex
      }
      else{
        select_tag.value = event.currentTarget.value
      }
    })
  }
  select_tag_is_activated(tag,checked){
    if(checked){
      tag.forEach((el)=>{el.disabled=false})
    }
    else{
      tag.forEach((el)=>{
        if(el.value.includes("[")){el.disabled=true}
      })
    }
  }
  setDepartment(event){
    console.log(this.all_select_department_tag)
    this.all_select_department_tag.forEach((el)=>{
      const select_tag = el;
      select_tag.selectedIndex = event.currentTarget.selectedIndex
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
  show_select_tag(event){
    console.log(event.currentTarget.value)
  }
  setCount() {
    if (this.hasCountTarget) {
      const count = this.selectedCheckboxes.length;
      this.countTarget.innerHTML = `${count} selected`;
    }
  }
  setStatusSelectTag(event){
    var item = event.currentTarget;
    const bool_checkbox = item.checked;
    const select_current_tag = new Array(...this.element.querySelectorAll('select#select_'+String(item.value)));
    this.select_tag_is_activated(select_current_tag,bool_checkbox);
  }
  get selectedCheckboxes() {
    return this.checkboxes.filter((c) => c.checked);
  }
  get checkboxes() {
    return new Array(...this.element.querySelectorAll("input[type=checkbox]"));
  }
  get all_select_tag(){
    return new Array(...this.element.querySelectorAll('.ot'))
  }
  get all_select_department_tag(){
    return new Array(...this.element.querySelectorAll('.department'))
  }
}
