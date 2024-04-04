<template>
  <div class="mt-2">
    <MaintenanceScheduleFilter :show-history="showHistory" :fetch-maintenance="fetchMaintenance" />
    <MaintenanceScheduleList
      :maintenance_schedules="maintenance_schedules"
      :vehicle="vehicle"
      :total="total"
      :del="del"
    />
  </div>
  <Loading ref="LoadingOverlay" :close-ov="closeOv" />
</template>

<script>
import axios from 'axios';
import { useRoute } from 'vue-router';
import { showToast } from '@/utils/showToast';
import MaintenanceScheduleList from '@/pages/panel/maintenance/MaintenanceScheduleList.vue';
import MaintenanceScheduleFilter from '@/pages/panel/maintenance/MaintenanceScheduleTab.vue';
import Loading from '@/pages/panel/util/Loading.vue';
import { LoadingMix } from '@/pages/panel/util/LoadingMix';

export default {
  name: 'App',
  components: { Loading, MaintenanceScheduleFilter, MaintenanceScheduleList },
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
    console.log(localStorage.getItem('showHistory'));
    console.log(this.showHistory);
    await this.fetchMaintenance(this.showHistory);
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
      localStorage.setItem('showHistory', showHistory);
      const params = new URLSearchParams({ show_history: this.showHistory });
      const maintenance_result = await axios.get('/api/v1/maintenance_schedules.json', {
        params: params,
      });
      this.maintenance_schedules = maintenance_result.data.data;
      this.total = maintenance_result.data.total;
      this.closeOv('LoadingOverlay');
    },
  },
};
</script>
