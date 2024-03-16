<template>
  <div class="mt-2">
    <MaintenanceScheduleFilter :show-history="showHistory" :fetch-maintenance="fetchMaintenance" />
    <MaintenanceScheduleList
      :maintenance_schedules="maintenance_schedules"
      :vehicle="vehicle"
      :del="del"
    />
  </div>
  <Loading ref="LoadingOverlay" :close-ov="closeOv" />
</template>

<script>
import axios from 'axios';
import { useRoute } from 'vue-router';
import { showToast } from '@/utils/showToast';
import MaintenanceScheduleList from '@/pages/panel/MaintenanceScheduleList.vue';
import MaintenanceScheduleFilter from '@/pages/panel/MaintenanceScheduleFilter.vue';
import Loading from '@/pages/panel/util/Loading.vue';

export default {
  name: 'App',
  components: { Loading, MaintenanceScheduleFilter, MaintenanceScheduleList },
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
      this.openOv('LoadingOverlay');
      this.showHistory = showHistory;
      const params = new URLSearchParams({ show_history: this.showHistory });
      const maintenance_result = await axios.get('/api/v1/maintenance_schedules.json', {
        params: params,
      });
      this.maintenance_schedules = maintenance_result.data;
      this.closeOv('LoadingOverlay');
    },
    openOv(id) {
      this.$refs[id].$el.style.width = '100%';
    },
    closeOv(id) {
      this.$refs[id].$el.style.width = '0%';
    },
  },
};
</script>
