# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@zxing/browser", to: "https://cdn.skypack.dev/pin/@zxing/browser@v0.1.5-YVf8rPO3ObrRfY7bPnC5/mode=imports,min/optimized/@zxing/browser.js"
