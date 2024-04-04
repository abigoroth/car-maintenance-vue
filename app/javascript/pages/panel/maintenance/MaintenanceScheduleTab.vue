<template>
  <v-tabs
    v-model="showHistoryTab"
    fixed-tabs
    bg-color="blue-grey-lighten-4"
    color="blue-grey-darken-1"
    slider-color="blue-grey-darken-4"
    selected-class="blue-grey-lighten-1"
  >
    <v-tab :value="false" @click="fetchMaintenance(false)"> Upcoming </v-tab>
    <v-tab :value="true" @click="fetchMaintenance(true)"> History </v-tab>
  </v-tabs>
</template>

<script>
export default {
  name: 'App',
  props: ['fetchMaintenance', 'showHistory'],
  data() {
    return {
      showHistoryTab: this.showHistory,
    };
  },
};
</script>
