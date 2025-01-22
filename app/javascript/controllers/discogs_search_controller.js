import { Controller } from "@hotwired/stimulus"
import { BrowserMultiFormatReader } from "@zxing/browser"


// Connects to data-controller="discogs-search"
export default class extends Controller {
  static targets = ["video", "input"]

  connect() {
    console.log("discogs-search controller connected")
  }

  scan() {
    const codeReader = new BrowserMultiFormatReader()
    console.log(codeReader)
    codeReader.decodeFromVideoDevice(undefined, this.videoTarget, (result, err, _) => {
      console.log(result)
      if (result) {
        this.inputTarget.value = result.getText()
      }
    })

    console.log(codeReader)
  }
}
