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
  <!-- Maintenance filter -->
  <div class="row">
    <div class="col-6 pr-0">
      <div
        class="btn btn-sm btn-primary d-flex"
        :class="{ active: !showHistory }"
        @click="fetchMaintenance(false)"
      >
        Upcoming
      </div>
    </div>
    <div class="col-6 pl-0">
      <div
        class="btn btn-sm btn-primary d-flex"
        :class="{ active: showHistory }"
        @click="fetchMaintenance(true)"
      >
        History
      </div>
    </div>
  </div>
  <!-- Maintenance filter END -->

  <div
    v-for="maintenance_schedule in maintenance_schedules"
    :key="maintenance_schedule.id"
    class="flex p-2 bg-white shadow-lg rounded-lg mt-3 overflow-hidden position-relative"
  >
    <h3 class="font-bold inline-block">{{ maintenance_schedule.part.name }}</h3>
    <span class="text-sm ml-2">
      {{ maintenance_schedule.date }} | {{ maintenance_schedule.target_mileage }}
    </span>
    <span
      class="material-symbols-outlined delete-item"
      @click="del(vehicle.id, maintenance_schedule.id)"
      >delete</span
    >
  </div>
</template>

<script>
import axios from 'axios';
import { useRoute } from 'vue-router';
import { showToast } from '@/utils/showToast';
const route = useRoute();

export default {
  name: 'App',
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
    async fetchData() {
      const result = await axios.get('/api/v1/vehicles/' + this.vehicleId);
      this.fetchMaintenance(this.showHistory);

      this.vehicle = result.data;
    },
    async fetchMaintenance(showHistory) {
      this.showHistory = showHistory;
      const params = new URLSearchParams({ show_history: this.showHistory });
      const maintenance_result = await axios.get(
        '/api/v1/vehicles/' + this.vehicleId + '/maintenance_schedules',
        { params: params },
      );
      this.maintenance_schedules = maintenance_result.data;
    },
  },
};
</script>
