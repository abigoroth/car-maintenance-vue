<template>
  <div class="flex p-2 bg-white shadow-lg rounded-lg m-2 overflow-hidden position-relative rounded">
    <div class="row">
      <div class="col-6 text-center">
        <h3>Total</h3>
        <span class="text-sm ml-2"> RM{{ total }} </span>
      </div>
      <div class="col-6 text-center">
        <h3>Tasks</h3>
        <span class="text-sm ml-2"> {{ maintenance_schedules.length }} </span>
      </div>
    </div>
  </div>
  <div
    v-for="maintenance_schedule in maintenance_schedules"
    :key="maintenance_schedule.id"
    class="flex p-2 bg-white shadow-lg rounded-lg m-2 overflow-hidden position-relative rounded"
  >
    <h3 class="font-bold inline-block" @click="store(maintenance_schedule)">
      {{ maintenance_schedule.part.name }}
      {{ vehicleId == null ? maintenance_schedule.vehicle.plate_number : '' }}
    </h3>
    <span class="text-sm ml-2">
      {{ maintenance_schedule.date }}
      {{ maintenance_schedule.mileage ? '- ' + maintenance_schedule.mileage + 'KM' : '' }}
    </span>
    <span
      class="material-symbols-outlined delete-item"
      @click="del(vehicle.id, maintenance_schedule.id)"
      >delete</span
    >
    <span
      class="material-symbols-outlined test-notification"
      @click="sendNotification(vehicle.id, maintenance_schedule.id)"
      >notifications_active</span
    >
  </div>
</template>
<script>
export default {
  name: 'App',
  props: ['maintenance_schedules', 'vehicle', 'del', 'sendNotification', 'vehicleId', 'total'],
  mounted() {
    console.log(this.vehicle.plate_number);
  },
  methods: {
    store(maintenance_schedule) {
      localStorage.setItem('vehicle', JSON.stringify(maintenance_schedule.vehicle));
      localStorage.setItem('maintenance_schedule', JSON.stringify(maintenance_schedule));
      console.log(maintenance_schedule);
      this.$router.push({
        name: 'maintenanceDetail',
        params: { vehicle_id: maintenance_schedule.vehicle_id, id: maintenance_schedule.id },
      });
    },
  },
};
</script>
