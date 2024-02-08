<template>
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
</template>

<script>
export default {
  name: 'App',
  props: ['fetchMaintenance', 'showHistory'],
};
</script>
