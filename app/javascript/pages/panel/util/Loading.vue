<template>
  <div class="overlay">
    <a href="javascript:void(0)" class="closebtn" @click="closeNav('maintenanceNav')">&times;</a>
    <div class="overlay-content">
      <div class="spinner-border text-light" role="status">
        <span class="sr-only">Loading...</span>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  name: 'App',
  props: ['closeNav'],
};
</script>
