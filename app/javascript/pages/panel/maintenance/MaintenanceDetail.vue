<template>
  <v-toolbar color="blue-grey-darken-4" dark>
    <v-btn
      icon
      class="hidden-xs-only"
      :to="{ name: 'maintenanceSchedules', params: { vehicle_id: vehicle.id } }"
    >
      <v-icon icon="mdi-arrow-left" />
    </v-btn>

    <v-toolbar-title>{{ vehicle.plate_number }}</v-toolbar-title>
  </v-toolbar>
  <v-list lines="one">
    <v-list-item>
      <v-list-item-title class="text-center">{{
        maintenance_schedule.part.name
      }}</v-list-item-title>
    </v-list-item>

    <v-list-item>
      <v-list-item-title>Car</v-list-item-title>
      <v-list-item-subtitle>
        {{ vehicle.make }} {{ vehicle.model }} {{ vehicle.plate_number }}
      </v-list-item-subtitle>
    </v-list-item>
    <v-list-item>
      <v-list-item-title>Date</v-list-item-title>
      <v-list-item-subtitle>
        {{ maintenance_schedule.date }}
      </v-list-item-subtitle>
    </v-list-item>
    <v-list-item v-if="maintenance_schedule.mileage">
      <v-list-item-title>Mileage</v-list-item-title>
      <v-list-item-subtitle>
        {{ maintenance_schedule.mileage }}
      </v-list-item-subtitle>
    </v-list-item>

    <v-list-item v-if="maintenance_schedule.note">
      <v-list-item-title>Note</v-list-item-title>
      <v-list-item-subtitle>
        {{ maintenance_schedule.note }}
      </v-list-item-subtitle>
    </v-list-item>

    <v-list-item v-if="maintenance_schedule.price">
      <v-list-item-title>Price</v-list-item-title>
      <v-list-item-subtitle>
        {{ maintenance_schedule.price }}
      </v-list-item-subtitle>
    </v-list-item>

    <v-list-item v-if="maintenance_schedule.status">
      <v-list-item-title>Status</v-list-item-title>
      <v-list-item-subtitle>
        {{ maintenance_schedule.status }}
      </v-list-item-subtitle>
    </v-list-item>

    <v-list-item>
      <button class="btn btn-primary d-flex w-100 justify-content-center" @click="edit">
        <span class="material-symbols-outlined"> edit </span>
        Edit Maintenance Schedule
      </button>
    </v-list-item>

    <v-list-item>
      <button
        v-if="maintenance_schedule.status === 'created'"
        class="btn btn-primary d-flex w-100 justify-content-center"
        @click="complete"
      >
        <span class="material-symbols-outlined">call_missed_outgoing</span>
        Mark as completed
      </button>
    </v-list-item>
  </v-list>
  <Loading ref="LoadingOverlay" :close-ov="closeOv" />
</template>

<script>
import axios from 'axios';
import { showToast } from '@/utils/showToast';
import Loading from '@/pages/panel/util/Loading.vue';

export default {
  name: 'App',
  components: { Loading },
  data() {
    return {
      vehicle: {},
      maintenance_schedule: {
        part: {
          name: '',
          date: '',
          mileage: '',
          note: '',
          price: '',
          status: '',
          workshop_id: '',
        },
      },
      vehicle_id: this.$router.currentRoute.value.params.vehicle_id,
      maintenance_schedule_id: this.$router.currentRoute.value.params.id,
    };
  },
  async mounted() {
    await this.fetchMaintenance();
  },
  methods: {
    async complete() {
      if (confirm('Are you sure ?')) {
        console.log(this.maintenance_schedule);
        const body = { status: 'completed' };
        await axios
          .put('/api/v1/maintenance_schedules/' + this.maintenance_schedule_id, body)
          .then(() => {
            this.$router.go(-1);
            showToast('Maintenance updated.', 'success');
          })
          .catch(() => {
            showToast('Maintenance updated.', 'error');
          });
      }
    },
    async fetchMaintenance() {
      this.openOv('LoadingOverlay');
      const maintenance_result = await axios.get(
        '/api/v1/vehicles/' +
          this.vehicle_id +
          '/maintenance_schedules/' +
          this.maintenance_schedule_id +
          '.json',
      );
      this.maintenance_schedule = maintenance_result.data;
      this.vehicle = this.maintenance_schedule.vehicle;
      localStorage.setItem('maintenance_schedule', JSON.stringify(this.maintenance_schedule));
      this.closeOv('LoadingOverlay');
    },
    edit() {
      this.$router.push({ name: 'editMaintenance' });
    },
    openOv(id) {
      this.$refs[id].$el.style.width = '100%';
    },
    closeOv(id) {
      this.$refs[id].$el.style.width = '0%';
    },
  },
};
</script>
