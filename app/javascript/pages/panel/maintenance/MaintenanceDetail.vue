<template>
  <div class="card border-light mb-3">
    <div class="card-header">
      <div class="position-relative">
        <a
          href="#"
          style="left: 0"
          class="item btn btn-sm btn-primary position-absolute font-weight-bold"
          @click="$router.go(-1)"
        >
          Back
        </a>
      </div>
      <h4 class="text-center">
        {{ vehicle.plate_number }}
      </h4>
    </div>
    <div class="card-body">
      <h5 class="card-title">{{ maintenance_schedule.part.name }}</h5>
      <div>
        <dl class="row">
          <dd class="col-sm-3">Date</dd>
          <dt class="col-sm-9">{{ maintenance_schedule.date }}</dt>
        </dl>
        <dl v-if="maintenance_schedule.mileage" class="row">
          <dd class="col-sm-3">Mileage</dd>
          <dt class="col-sm-9">{{ maintenance_schedule.mileage }}</dt>
        </dl>
        <dl v-if="maintenance_schedule.note" class="row">
          <dd class="col-sm-3">Note</dd>
          <dt class="col-sm-9">{{ maintenance_schedule.note }}</dt>
        </dl>
        <dl class="row">
          <dd class="col-sm-3">Price</dd>
          <dt class="col-sm-9">{{ maintenance_schedule.price }}</dt>
        </dl>
        <dl v-if="maintenance_schedule.status" class="row">
          <dd class="col-sm-3">Status</dd>
          <dt class="col-sm-9">{{ maintenance_schedule.status }}</dt>
        </dl>
        <dl v-if="maintenance_schedule.workshop_id" class="row">
          <dd class="col-sm-3">Workshop</dd>
          <dt class="col-sm-9">{{ maintenance_schedule.workshop_id }}</dt>
        </dl>
      </div>
      <div class="text-center" style="margin-bottom: 50px">
        <button
          v-if="maintenance_schedule.status === 'created'"
          class="btn btn-primary d-flex w-100 justify-content-center mb-2"
          @click="edit"
        >
          <span class="material-symbols-outlined"> edit </span>
          Edit Maintenance Schedule
        </button>

        <button
          v-if="maintenance_schedule.status === 'created'"
          class="btn btn-primary d-flex w-100 justify-content-center"
          @click="complete"
        >
          <span class="material-symbols-outlined">call_missed_outgoing</span>
          Mark as completed
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import { showToast } from '@/utils/showToast';

export default {
  name: 'App',
  computed: {
    maintenance_schedule() {
      return JSON.parse(localStorage.getItem('maintenance_schedule'));
    },
    vehicle() {
      return JSON.parse(localStorage.getItem('vehicle'));
    },
  },
  methods: {
    async complete() {
      if (confirm('Are you sure ?')) {
        console.log(this.maintenance_schedule);
        const body = { status: 'completed' };
        await axios
          .put('/api/v1/maintenance_schedules/' + this.maintenance_schedule.id, body)
          .then(() => {
            this.$router.go(-1);
            showToast('Maintenance updated.', 'success');
          })
          .catch(() => {
            showToast('Maintenance updated.', 'error');
          });
      }
    },
    edit() {
      this.$router.push({ name: 'editMaintenance' });
    },
  },
};
</script>
