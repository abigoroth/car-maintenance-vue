<template>
  <v-toolbar dark>
    <v-toolbar-title>Your Vehicles</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn icon class="hidden-xs-only" :to="{ name: 'vehiclesNew' }">
      <v-icon icon="mdi-plus" />
    </v-btn>
  </v-toolbar>

  <div
    v-for="vehicle in vehicles"
    :key="vehicle.id"
    class="flex p-2 bg-white shadow-lg rounded-lg m-2 overflow-hidden position-relative rounded"
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
  <Loading ref="LoadingOverlay" :close-ov="closeOv" />
</template>

<script>
import axios from 'axios';
import { showToast } from '@/utils/showToast';
import { LoadingMix } from '@/pages/panel/util/LoadingMix';
import Loading from '@/pages/panel/util/Loading.vue';
export default {
  name: 'App',
  components: { Loading },
  mixins: [LoadingMix],
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
      this.openOv('LoadingOverlay');
      const result = await axios.get('/api/v1/vehicles/');
      this.vehicles = result.data;
      this.closeOv('LoadingOverlay');
    },
  },
};
</script>
