import { Controller } from "@hotwired/stimulus"
import { BrowserMultiFormatReader } from "@zxing/browser"


export default class extends Controller {
  static targets = ["video", "input", "form"]

  connect() {
    this.inputTarget.focus();
  }

  

  scan() {
    const codeReader = new BrowserMultiFormatReader()
    // this.
    codeReader.decodeFromVideoDevice(undefined, this.videoTarget, (result, err, _) => {
      if (result) {
        this.inputTarget.value = result.getText()
        this.formTarget.requestSubmit()
        codeReader.reset()
      }
    })
  }

  closeScan() {
    codeReader.reset()
  }
}
