const Index = () => import('@/pages/panel/IndexPage.vue');
const Vehicles = () => import('@/pages/panel/VehiclesPage.vue');
const VehiclesNew = () => import('@/pages/panel/VehiclesNewPage.vue');

const routes = [
  {
    path: '/',
    name: 'index',
    components: {
      default: Index,
    },
  },
  {
    path: '/vehicles',
    name: 'vehicles',
    components: {
      default: Vehicles,
    },
  },
  {
    path: '/vehicles/new',
    name: 'vehiclesNew',
    components: {
      default: VehiclesNew,
    },
  },
];

export default routes;
