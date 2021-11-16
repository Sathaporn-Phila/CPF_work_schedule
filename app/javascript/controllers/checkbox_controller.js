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

  get selectedCheckboxes() {
    return this.checkboxes.filter((c) => c.checked);
  }

  get checkboxes() {
    return new Array(...this.element.querySelectorAll("input[type=checkbox]"));
  }
}
