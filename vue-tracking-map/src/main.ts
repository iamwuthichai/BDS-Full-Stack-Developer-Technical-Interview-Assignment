import './assets/main.css'
import './input.css';

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(router)

// ปิด devtools overlay
app.config.devtools = false;

app.mount('#app')
