import { message } from '@/utils/discrete_api';
import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      component: () => import('@/views/IndexView.vue')
    },
    {
      path: '/login',
      component: () => import('@/views/LoginView.vue')
    },
    {
      path: '/admin',
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import('@/views/AdminView.vue'),
      children: [
        {
          path: '/admin',
          component: () => import('@/components/admin/IndexComponent.vue'),
        },
        {
          path: '/admin/computer_all',
          component: () => import('@/components/admin/computer/ComputerAll.vue'),
        },
        {
          path: '/admin/push_notice',
          component: () => import('@/components/admin/notice/PushNotice.vue'),
        },
        {
          path: '/admin/list_notice',
          component: () => import('@/components/admin/notice/ListNotice.vue'),
        },
        {
          path: '/admin/create_cdk',
          component: () => import('@/components/admin/cdk/CreateCdk.vue'),
        },
        {
          path: '/admin/history_cdk',
          component: () => import('@/components/admin/cdk/HistoryCdk.vue'),
        },
        {
          path: '/admin/show_cdk',
          component: () => import('@/components/admin/cdk/ShowCdk.vue'),
        },
      ],
      meta: {
        requiresAuth: true
      }
    }
  ]
})

router.beforeEach((to, from, next) => {
  let requiresAuth = to.matched.some(record => record.meta.requiresAuth);

  const isAuthenticated = localStorage.getItem('token');

  if (requiresAuth && !isAuthenticated) {
    next('/login')
  } else {
    next()
  }
})

export default router
