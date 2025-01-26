import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = true
window.Stimulus   = application


addEventListener("turbo:render", (event) => {
    console.log("Turbo Rendered with: ", event.detail.renderMethod)
});


export { application }
