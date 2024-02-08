<template>
  <div class="mt-2">
    <MaintenanceScheduleFilter :show-history="showHistory" :fetch-maintenance="fetchMaintenance" />
    <MaintenanceScheduleList
      :maintenance_schedules="maintenance_schedules"
      :vehicle="vehicle"
      :del="del"
    />
  </div>
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
    await this.fetchMaintenance();
  },
  methods: {
    del(vehicleId, id) {
      if (confirm('Do you really want to delete?')) {
        axios
          .delete('/api/v1/maintenance_schedules/' + id)
          .then((resp) => {
            showToast('Maintenance Schedule Deleted');
            this.fetchMaintenance();
          })
          .catch((error) => {
            console.log(error);
          });
      }
    },
    async fetchMaintenance(showHistory) {
      this.showHistory = showHistory;
      const params = new URLSearchParams({ show_history: this.showHistory });
      const maintenance_result = await axios.get('/api/v1/maintenance_schedules.json', {
        params: params,
      });
      this.maintenance_schedules = maintenance_result.data;
    },
  },
};
</script>
