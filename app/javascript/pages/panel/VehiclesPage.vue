<template>
  <h2 class="text-center">Welcome to the CarPage</h2>
  <p>{{ $router.currentRoute.value.path }}</p>
  <table class="table">
    <thead>
      <th>Make</th>
      <th>Model</th>
      <th>Year</th>
      <th>Mileage</th>
      <th>Vin Number</th>
    </thead>
    <tbody>
      <tr v-for="vehicle in vehicles" :key="vehicle.id">
        <td>{{ vehicle.make }}</td>
        <td>{{ vehicle.model }}</td>
        <td>{{ vehicle.year }}</td>
        <td>{{ vehicle.mileage }}</td>
        <td>{{ vehicle.vin_number }}</td>
        <td>{{ vehicle.plate_number }}</td>
      </tr>
    </tbody>
    <tbody></tbody>
  </table>
  <router-link :to="{ name: 'vehiclesNew' }" class="item"> New Vehicle </router-link>
</template>

<script>
import axios from 'axios';
export default {
  name: 'App',
  data() {
    return {
      vehicles: [],
    };
  },
  async mounted() {
    const result = await axios.get('/api/v1/vehicles');
    this.vehicles = result.data;
  },
};
</script>
