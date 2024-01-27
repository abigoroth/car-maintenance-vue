<template>
  <h2 class="text-center">{{ vehicle.plate_number }}</h2>
  <h5>Maintenance schedule</h5>
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
  <div
    class="item btn btn-primary position-absolute top-0"
    style="left: 10px"
    @click="$router.go(-1)"
  >
    Back
  </div>
  <div class="mb-60"></div>

  <router-link
    :to="{ name: 'maintenanceScheduleNew' }"
    class="item btn btn-primary position-absolute top-0"
    style="right: 10px"
  >
    Add
  </router-link>
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
      const id = this.$router.currentRoute.value.params.vehicle_id;
      const result = await axios.get('/api/v1/vehicles/' + id);
      const maintenance_result = await axios.get(
        '/api/v1/vehicles/' + id + '/maintenance_schedules',
      );

      this.vehicle = result.data;
      this.maintenance_schedules = maintenance_result.data;
    },
  },
};
</script>
