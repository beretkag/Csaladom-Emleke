import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
import store from './store/store'
import "../node_modules/bootstrap/dist/css/bootstrap.min.css"
import "../node_modules/bootstrap/dist/js/bootstrap.bundle.min.js"
import "bootstrap"
import "../node_modules/bootstrap-icons/font/bootstrap-icons.css"
import sha256 from "crypto-js/sha256"

const app = createApp(App)

app.use(router)

app.use(store)

app.mount('#app')
