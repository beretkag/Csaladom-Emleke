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
      path:'/eletut/:nodeid',
      name:'Életút',
      component: () => import('../views/eletut.vue'),
      props: route=> ({...route.params, nodeid:route.params.nodeid})
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
        }
      ]
    },
   
  ]
})

export default router
