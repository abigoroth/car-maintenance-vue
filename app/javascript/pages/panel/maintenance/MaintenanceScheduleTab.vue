<template>
  <v-tabs v-model="showHistoryTab" fixed-tabs>
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
