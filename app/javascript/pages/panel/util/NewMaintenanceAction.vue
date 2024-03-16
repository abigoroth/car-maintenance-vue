<template>
  <div class="overlay">
    <a href="javascript:void(0)" class="closebtn" @click="closeOv('maintenanceAction')">&times;</a>
    <div class="overlay-content">
      <router-link :to="{ name: 'maintenanceScheduleNew', params: { status: 'created' } }">
        Add Maintenance
      </router-link>
      <hr />
      <router-link :to="{ name: 'maintenanceScheduleNew', params: { status: 'completed' } }">
        Add History
      </router-link>
    </div>
  </div>
</template>
<script>
export default {
  name: 'App',
  props: ['closeOv'],
};
</script>
