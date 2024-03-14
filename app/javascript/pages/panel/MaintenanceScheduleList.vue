<template>
  <div
    v-for="maintenance_schedule in maintenance_schedules"
    :key="maintenance_schedule.id"
    class="flex p-2 bg-white shadow-lg rounded-lg mt-3 overflow-hidden position-relative rounded"
  >
    <h3 class="font-bold inline-block">
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
  props: ['maintenance_schedules', 'vehicle', 'del', 'sendNotification', 'vehicleId'],
};
</script>
