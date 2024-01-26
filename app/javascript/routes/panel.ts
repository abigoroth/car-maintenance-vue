const Index = () => import('@/pages/panel/IndexPage.vue');
const Contact = () => import('@/pages/panel/ContactPage.vue');
const Vehicles = () => import('@/pages/panel/VehiclesPage.vue');
const VehicleShow = () => import('@/pages/panel/VehicleShowPage.vue');
const MaintenanceScheduleNew = () => import('@/pages/panel/MaintenanceScheduleNewPage.vue');
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
  {
    path: '/vehicles/:id',
    name: 'vehicleShow',
    components: {
      default: VehicleShow,
    },
  },
  {
    path: '/vehicles/:id/maintenance_schedules/new',
    name: 'maintenanceScheduleNew',
    components: {
      default: MaintenanceScheduleNew,
    },
  },
  {
    path: '/contact',
    name: 'contact',
    components: {
      default: Contact,
    },
  },
];

export default routes;
