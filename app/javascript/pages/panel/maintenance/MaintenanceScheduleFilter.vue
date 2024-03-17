<template>
  <!-- Maintenance filter -->
  <div class="row">
    <nav>
      <div id="nav-tab" class="nav nav-tabs" role="tablist">
        <button
          id="nav-home-tab"
          class="nav-link"
          :class="{ active: !showHistory }"
          data-bs-toggle="tab"
          data-bs-target="#nav-home"
          type="button"
          role="tab"
          aria-controls="nav-home"
          aria-selected="{{ !showHistory ? 'true' : 'false' }}"
          @click="fetchMaintenance(false)"
        >
          Upcoming
        </button>
        <button
          id="nav-profile-tab"
          class="nav-link"
          :class="{ active: showHistory }"
          data-bs-toggle="tab"
          data-bs-target="#nav-profile"
          type="button"
          role="tab"
          aria-controls="nav-profile"
          aria-selected="{{ showHistory ? 'true' : 'false' }}"
          @click="fetchMaintenance(true)"
        >
          History
        </button>
      </div>
    </nav>
  </div>
  <!-- Maintenance filter END -->
</template>

<script>
export default {
  name: 'App',
  props: ['fetchMaintenance', 'showHistory'],
};
</script>
