// Import Stimulus and start it
import { Application } from "@hotwired/stimulus"

const application = Application.start()
application.debug = false
window.Stimulus = application
export { application }

// Import jQuery and attach it to the window (if needed)
import "jquery"
window.$ = window.jQuery

// Import and start Rails UJS
import Rails from "@rails/ujs"
Rails.start()

