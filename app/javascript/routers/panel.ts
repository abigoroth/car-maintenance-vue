import { createRouter, createWebHistory } from 'vue-router';
import routes from '@/routes/maintenance';

const router = createRouter({
  history: createWebHistory('/panel/'),
  routes,
});

export default router;
