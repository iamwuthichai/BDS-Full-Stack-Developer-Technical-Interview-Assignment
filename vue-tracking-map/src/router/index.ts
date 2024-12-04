import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '@/views/HomeView.vue'
import MapView from '../views/MapView.vue'
import MapSearchSiteView from '@/views/MapSearchSiteView.vue'
import MapNavigate from '@/views/MapNavigate.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    // {
    //   path: '/',
    //   name: 'home',
    //   component: HomeView,
    // },
    {
      path: '/',
      name: 'home',
      component: MapView,
    },
    {
      path: '/mapview',
      name: 'mapview',
      component: MapView,
    },
    {
      path: '/mapview/find-branch',
      name: 'find_branch',
      component: MapSearchSiteView,
      props: true, // เปิดให้ props รับค่า params
    },
    {
      path: '/mapview/confirm-and-navigate',
      name: 'confirm_and_navigate',
      component: MapNavigate,
      props: true, // เปิดให้ props รับค่า params
    },
  ],
})

export default router
