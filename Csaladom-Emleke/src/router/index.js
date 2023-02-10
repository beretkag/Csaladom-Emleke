import { createRouter, createWebHistory } from 'vue-router'
import Index from '../views/Index.vue'
import Contacts from '../components/family/contacts.vue'
import HowToStart from '../components/howtostart.vue'
import Settings from '../components/settings.vue'
import UserManagment from '../components/usermanagment.vue'
import Family from '../views/csalad.vue'
import FamilyMenu from '../components/family/familymenu.vue'
import FamilyTree from '../components/family/familytree.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'index',
      component: Index
    },
    {
      path: '/elerhetosegek',
      name: 'contacts',
      component: Contacts
    },
    {
      path: '/hogyankezdjneki',
      name: 'howtostart',
      component: HowToStart 
    },
    {
      path: '/beallitasok',
      name: 'settings',
      component: Settings
    },
    {
      path: '/felhasznalokezeles',
      name: 'usermanagment',
      component: UserManagment
    },
    {
      path:'/csalad',
      name:'family',
      component: Family
    },
    {
      path:'/familymenu',
      name:'familymenu',
      component: FamilyMenu
    },
    {
      path:'/csaladfa',
      name:'familytree',
      component: FamilyTree
    }
   

    /*{
      path: '/about',
      name: 'about',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('../views/AboutView.vue')
    }*/
  ]
})

export default router
