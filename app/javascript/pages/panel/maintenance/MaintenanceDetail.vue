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
          <dd class="col-sm-3">Car</dd>
          <dt class="col-sm-9">{{ vehicle.make }} {{ vehicle.model }}</dt>
        </dl>
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
        <button class="btn btn-primary d-flex w-100 justify-content-center mb-2" @click="edit">
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
