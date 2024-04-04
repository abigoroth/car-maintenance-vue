<template>
  <v-toolbar dark>
    <v-btn class="hidden-xs-only" :to="{ name: 'vehicles' }">
      <v-icon icon="mdi-arrow-left" />
    </v-btn>

    <v-toolbar-title>{{ vehicle.plate_number }}</v-toolbar-title>

    <v-spacer></v-spacer>

    <v-btn icon class="hidden-xs-only" @click="openOv('maintenanceOv')">
      <v-icon icon="mdi-plus" />
    </v-btn>
  </v-toolbar>
  <MaintenanceScheduleFilter :show-history="showHistory" :fetch-maintenance="fetchMaintenance" />
  <MaintenanceScheduleList
    :maintenance_schedules="maintenance_schedules"
    :vehicle="vehicle"
    :total="total"
    :send-notification="sendNotification"
    :del="del"
    :vehicle-id="vehicleId"
  />
  <ActionOverlay ref="maintenanceOv" :close-ov="closeOv" />
  <Loading ref="LoadingOverlay" :close-ov="closeOv" />
</template>

<script>
import axios from 'axios';
import { showToast } from '@/utils/showToast';
import MaintenanceScheduleList from '@/pages/panel/maintenance/MaintenanceScheduleList.vue';
import MaintenanceScheduleFilter from '@/pages/panel/maintenance/MaintenanceScheduleTab.vue';
import ActionOverlay from '@/pages/panel/util/ActionOverlay.vue';
import Loading from '@/pages/panel/util/Loading.vue';
import { LoadingMix } from '@/pages/panel/util/LoadingMix';

export default {
  name: 'App',
  components: { MaintenanceScheduleFilter, MaintenanceScheduleList, ActionOverlay, Loading },
  mixins: [LoadingMix],
  data() {
    return {
      total: 0,
      vehicle: {},
      maintenance_schedules: [],
      parts: [],
      showAdd: false,
      showHistory: JSON.parse(localStorage.getItem('showHistory')),
      vehicleId: this.$router.currentRoute.value.params.vehicle_id,
    };
  },
  async mounted() {
    if (localStorage.getItem('showHistory') !== 'undefined') {
      localStorage.setItem('showHistory', 'false');
    }
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
      this.openOv('LoadingOverlay');
      const result = await axios.get('/api/v1/vehicles/' + this.vehicleId);
      await this.fetchMaintenance(this.showHistory);

      this.vehicle = result.data;
    },
    async fetchMaintenance(showHistory) {
      this.openOv('LoadingOverlay');
      this.showHistory = showHistory;
      localStorage.setItem('showHistory', showHistory);
      const params = new URLSearchParams({ show_history: this.showHistory });
      const maintenance_result = await axios.get(
        '/api/v1/vehicles/' + this.vehicleId + '/maintenance_schedules.json',
        { params: params },
      );
      this.maintenance_schedules = maintenance_result.data.data;
      this.total = maintenance_result.data.total;
      this.closeOv('LoadingOverlay');
    },
  },
};
// TODO: Total expenses per car, or even per year graph.
</script>
