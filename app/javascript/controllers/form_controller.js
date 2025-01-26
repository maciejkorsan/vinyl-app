import { Controller } from "@hotwired/stimulus"
import debounce from "debounce";

export default class extends Controller {
  connect() {
    this.submit = debounce(this.submit, 500);
  }

  submit() {
    this.element.requestSubmit();
  }
}
