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
      @click="showAdd = !showAdd"
    >
      Add
    </div>
    <h2 class="text-center">{{ vehicle.plate_number }}</h2>
  </div>
  <div v-if="showAdd">
    <router-link
      :to="{ name: 'maintenanceScheduleNew', params: { status: 'created' } }"
      class="btn btn-primary btn-sm d-flex mb-2 text-center"
    >
      Add Maintenance
    </router-link>
    <router-link
      :to="{ name: 'maintenanceScheduleNew', params: { status: 'completed' } }"
      class="btn btn-primary btn-sm d-flex mb-2 text-center"
    >
      Add History
    </router-link>
  </div>
  <MaintenanceScheduleFilter :show-history="showHistory" :fetch-maintenance="fetchMaintenance" />
  <MaintenanceScheduleList
    :maintenance_schedules="maintenance_schedules"
    :vehicle="vehicle"
    :send-notification="sendNotification"
    :del="del"
  />
</template>

<script>
import axios from 'axios';
import { useRoute } from 'vue-router';
import { showToast } from '@/utils/showToast';
import MaintenanceScheduleList from '@/pages/panel/MaintenanceScheduleList.vue';
import MaintenanceScheduleFilter from '@/pages/panel/MaintenanceScheduleFilter.vue';
const route = useRoute();

export default {
  name: 'App',
  components: { MaintenanceScheduleFilter, MaintenanceScheduleList },
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
