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
      path:'/csalad/:csaladfaID',
      name:'family',
      component: () => import('../views/Csalad.vue'),
      props: route=>({...route.params, csaladfaID: route.params.csaladfaID}),
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
          path: 'Csaladfak',
          name:'Családfák',
          component: () => import('../components/family/familymenu/csaladfak.vue')
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
        },
        { path: '/:pathMatch(.*)*', redirect: '/' }
      ]
    },
    { path: '/:pathMatch(.*)*', redirect: '/' }
  ]
})


export default router
