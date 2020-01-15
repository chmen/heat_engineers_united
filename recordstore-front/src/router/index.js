import Vue from 'vue'
import Router from 'vue-router'
import Signin from '@/components/Signin'
import Signup from '@/components/Signup'
import Artists from '@/components/Artists'
import Records from '@/components/Records'
import Companies from '@/components/Companies'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'Signin',
      component: Signin
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    },
    {
      path: '/artists',
      name: 'Artists',
      component: Artists
    },
    {
      path: '/records',
      name: 'Records',
      component: Records
    },
    {
      path: '/companies',
      name: 'Companies',
      component: Companies
    }
  ]
})
