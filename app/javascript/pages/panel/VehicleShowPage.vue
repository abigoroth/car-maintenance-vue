<template>
  <h2 class="text-center">{{ vehicle.plate_number }}</h2>
  <h5>Maintenance schedule</h5>
  <table class="table">
    <thead>
      <th>Part</th>
      <th>Date</th>
      <th>Target Mileage</th>
      <th>status</th>
    </thead>
    <tbody>
      <tr v-for="maintenance_schedule in maintenance_schedules" :key="maintenance_schedule.id">
        <td>{{ maintenance_schedule.part_id }}</td>
        <td>{{ maintenance_schedule.date }}</td>
        <td>{{ maintenance_schedule.target_mileage }}</td>
        <td>{{ maintenance_schedule.status }}</td>
      </tr>
    </tbody>
    <tbody></tbody>
  </table>
  <router-link :to="{ name: 'maintenanceScheduleNew' }" class="item">
    New Maintenance Schedule</router-link
  >
</template>

<script>
import axios from 'axios';
import { useRoute } from 'vue-router';
const route = useRoute();
export default {
  name: 'App',
  data() {
    return {
      vehicle: {},
      maintenance_schedules: [],
    };
  },
  async mounted() {
    const id = this.$router.currentRoute.value.params.id;
    const result = await axios.get('/api/v1/vehicles/' + id);
    const maintenance_result = await axios.get('/api/v1/vehicles/' + id + '/maintenance_schedules');
    this.vehicle = result.data;
    this.maintenance_schedules = maintenance_result.data;
  },
};
</script>
