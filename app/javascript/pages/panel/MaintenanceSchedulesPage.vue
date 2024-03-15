<template>
  <div class="header mt-2 position-relative">
    <router-link
      :to="{ name: 'vehicles' }"
      style="left: 0"
      class="item btn btn-sm btn-primary position-absolute font-weight-bold"
    >
      Back
    </router-link>
    <div
      class="item btn btn-sm btn-primary position-absolute right"
      style="right: 0"
      @click="openNav('maintenanceNav')"
    >
      Add
    </div>
    <h2 class="text-center">{{ vehicle.plate_number }}</h2>
  </div>
  <MaintenanceScheduleFilter :show-history="showHistory" :fetch-maintenance="fetchMaintenance" />
  <MaintenanceScheduleList
    :maintenance_schedules="maintenance_schedules"
    :vehicle="vehicle"
    :send-notification="sendNotification"
    :del="del"
    :vehicle-id="vehicleId"
  />
  <ActionOverlay ref="maintenanceNav" :close-nav="closeNav" :open-nav="openNav" />
</template>

<script>
import axios from 'axios';
import { useRoute } from 'vue-router';
import { showToast } from '@/utils/showToast';
import MaintenanceScheduleList from '@/pages/panel/MaintenanceScheduleList.vue';
import MaintenanceScheduleFilter from '@/pages/panel/MaintenanceScheduleFilter.vue';
import ActionOverlay from '@/pages/panel/util/ActionOverlay.vue';
const route = useRoute();

export default {
  name: 'App',
  components: { MaintenanceScheduleFilter, MaintenanceScheduleList, ActionOverlay },
  data() {
    return {
      vehicle: {},
      maintenance_schedules: [],
      parts: [],
      showAdd: false,
      showHistory: false,
      vehicleId: this.$router.currentRoute.value.params.vehicle_id,
    };
  },
  async mounted() {
    await this.fetchData();
  },
  methods: {
    openNav(id) {
      this.$refs[id].$el.style.width = '100%';
    },
    closeNav(id) {
      this.$refs[id].$el.style.width = '0%';
    },
    del(vehicle_id, id) {
      if (confirm('Do you really want to delete?')) {
        axios
          .delete('/api/v1/vehicles/' + vehicle_id + '/maintenance_schedules/' + id)
          .then((resp) => {
            showToast('Maintenance Schedule Deleted');
            this.fetchData();
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
    sendNotification(vehicle_id, id) {
      if (confirm('Test notification?')) {
        axios
          .get(
            '/api/v1/vehicles/' +
              vehicle_id +
              '/maintenance_schedules/' +
              id +
              '/send_notification',
          )
          .then((resp) => {
            showToast('Maintenance Schedule Deleted');
            this.fetchData();
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
    async fetchData() {
      const result = await axios.get('/api/v1/vehicles/' + this.vehicleId);
      this.fetchMaintenance(this.showHistory);

      this.vehicle = result.data;
    },
    async fetchMaintenance(showHistory) {
      this.showHistory = showHistory;
      const params = new URLSearchParams({ show_history: this.showHistory });
      const maintenance_result = await axios.get(
        '/api/v1/vehicles/' + this.vehicleId + '/maintenance_schedules.json',
        { params: params },
      );
      this.maintenance_schedules = maintenance_result.data;
    },
  },
};
// TODO: Total expenses per car, or even per year graph.
</script>
