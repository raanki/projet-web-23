import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', redirect: '/dashboard' },
    {
      path: '/',
      component: () => import('../layouts/default.vue'),
      children: [
        {
          path: 'dashboard',
          component: () => import('../pages/dashboard.vue'),
        },
        {
          path: 'account-settings',
          component: () => import('../pages/account-settings.vue'),
        },
        {
          path: 'typography',
          component: () => import('../pages/typography.vue'),
        },
        {
          path: 'icons',
          component: () => import('../pages/icons.vue'),
        },
        {
          path: 'cards',
          component: () => import('../pages/cards.vue'),
        },
        {
          path: 'tables',
          component: () => import('../pages/tables.vue'),
        },
        {
          path: 'form-layouts',
          component: () => import('../pages/form-layouts.vue'),
        },
        {
          path: 'equipment',
          component: () => import('../pages/equipment.vue'),
        },
        {
          path: 'loan',
          component: () => import('../pages/loan.vue'),
        },
        {
          path: 'loan/create',
          component: () => import('../pages/create-loan.vue'),
        },
        {
          path: 'loan/see/:id',
          component: () => import('../pages/create-loan.vue'),
          props: route => ({ action: 'view', id: route.params.id }),
        },
        {
          path: 'loan/edit/:id',
          component: () => import('../pages/create-loan.vue'),
          props: route => ({ action: 'edit', id: route.params.id }),
        },
        {
          path: 'equipment/create',
          component: () => import('../pages/create-equipment.vue'),
          props: { action: 'create' },
        },
        {
          path: 'equipment/edit/:id',
          component: () => import('../pages/create-equipment.vue'),
          props: route => ({ action: 'edit', id: route.params.id }),
        },
        {
          path: 'equipment/see/:id',
          component: () => import('../pages/create-equipment.vue'),
          props: route => ({ action: 'view', id: route.params.id }),
        },
        {
          path: 'student',
          component: () => import('../pages/student.vue'),
        },
        {
          path: 'student/see/:id',
          component: () => import('../pages/create-user.vue'),
          props: route => ({ action: 'view', id: route.params.id }),
        },
        {
          path: 'student/edit/:id',
          component: () => import('../pages/create-user.vue'),
          props: route => ({ action: 'view', id: route.params.id }),
        },
        {
          path: 'admin',
          component: () => import('../pages/admin.vue'),
        },
        {
          path: 'user/create',
          component: () => import('../pages/create-user.vue'),
        },
        {
          path: 'user/edit/:id',
          component: () => import('../pages/create-user.vue'),
          props: route => ({ action: 'edit', id: route.params.id }),
        },
        {
          path: 'user/see/:id',
          component: () => import('../pages/create-user.vue'),
          props: route => ({ action: 'view', id: route.params.id }),
        },
      ],
    },
    {
      path: '/',
      component: () => import('../layouts/blank.vue'),
      children: [
        {
          path: 'login',
          component: () => import('../pages/login.vue'),
        },
        {
          path: 'register',
          component: () => import('../pages/register.vue'),
        },
        {
          path: '/:pathMatch(.*)*',
          component: () => import('../pages/[...all].vue'),
        },
      ],
    },
  ],
})

export default router
