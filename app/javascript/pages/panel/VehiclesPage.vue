<template>
  <div class="header mt-2 bg-white">
    <h2 class="text-center">Your Vehicles</h2>
    <router-link
      :to="{ name: 'vehiclesNew' }"
      class="item btn btn-sm btn-primary position-absolute"
      style="right: 10px; top: 10px"
    >
      Add
    </router-link>
  </div>
  <div
    v-for="vehicle in vehicles"
    :key="vehicle.id"
    class="flex p-2 bg-white shadow-lg rounded-lg mt-3 overflow-hidden position-relative"
  >
    <router-link
      :to="{ name: 'maintenanceSchedules', params: { vehicle_id: vehicle.id } }"
      class="no-underline"
      style="text-decoration: none !important"
    >
      <h3 class="font-bold inline-block list-item">{{ vehicle.plate_number }}</h3>
    </router-link>
    <span class="text-sm ml-2"> {{ vehicle.make }} {{ vehicle.model }} </span>
    <div class="material-symbols-outlined delete-item" @click="del(vehicle.id)">delete</div>
  </div>
  <div class="mb-60"></div>
</template>

<script>
import axios from 'axios';
import { showToast } from '@/utils/showToast';
export default {
  name: 'App',
  data() {
    return {
      vehicles: [],
    };
  },
  async mounted() {
    await this.fetchData();
  },
  methods: {
    del(vehicle_id) {
      if (confirm('Do you really want to delete?')) {
        axios
          .delete('/api/v1/vehicles/' + vehicle_id)
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
      const result = await axios.get('/api/v1/vehicles/');
      this.vehicles = result.data;
    },
  },
};
</script>
