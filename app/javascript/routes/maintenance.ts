import EditMaintenance from '@/pages/panel/maintenance/EditMaintenance.vue';

const Index = () => import('@/pages/panel/MaintenanceSchedulesPage.vue');
const Contact = () => import('@/pages/panel/ContactPage.vue');
const Vehicles = () => import('@/pages/panel/VehiclesPage.vue');
const MaintenanceSchedules = () => import('@/pages/panel/VehicleMaintenanceSchedulesPage.vue');
const MaintenanceScheduleNew = () =>
  import('@/pages/panel/maintenance/MaintenanceScheduleNewPage.vue');
const MaintenanceDetail = () => import('@/pages/panel/maintenance/MaintenanceDetail.vue');
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
    path: '/vehicles/:vehicle_id',
    name: 'maintenanceSchedules',
    components: {
      default: MaintenanceSchedules,
    },
  },
  {
    path: '/vehicles/:vehicle_id/maintenance_schedules/new/:status',
    name: 'maintenanceScheduleNew',
    components: {
      default: MaintenanceScheduleNew,
    },
  },
  {
    path: '/vehicles/:vehicle_id/maintenance_schedules/:id',
    name: 'maintenanceDetail',
    components: {
      default: MaintenanceDetail,
    },
  },
  {
    path: '/vehicles/:vehicle_id/maintenance_schedules/:id/edit',
    name: 'editMaintenance',
    components: {
      default: EditMaintenance,
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
