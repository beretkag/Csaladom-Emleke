import { createRouter, createWebHistory } from 'vue-router'
import Index from '../views/Index.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'index',
      component: Index
    },
    {
      path: '/hogyankezdjneki',
      name: 'howtostart',
      component: () => import('../views/HowToView.vue')
    },
    {
      path:'/csalad',
      name:'family',
      component: () => import('../views/Csalad.vue'),
      children:[
        {
          path:'Beallitasok',
          name: 'Beállítások',
          component: () => import('../components/family/familymenu/beallitasok.vue')
        },
        {
          path: 'FelhasznaloKezeles',
          name: 'Felhasználó-Kezelés',
          component: () => import('../components/family/familymenu/felhasznalokezeles.vue')
        },
        {
          path:'namemod',
          name:'namemod',
          component: () => import('../components/family/familymenu/felhasznalokezeles/nev_mod.vue')
        },  
        {
          path:'emailmod',
          name:'emailmod',
          component: () => import('../components/family/familymenu/felhasznalokezeles/emailcim_mod.vue')
        },
        {
          path:'passmod',
          name:'passmod',
          component: () => import('../components/family/familymenu/felhasznalokezeles/jelszo_mod.vue')
        }
      ]
    },
   
  ]
})

export default router
