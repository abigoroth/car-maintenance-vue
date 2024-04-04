<template>
  <v-toolbar dark>
    <v-btn class="hidden-xs-only" @click="routerBack">
      <v-icon icon="mdi-arrow-left" />
    </v-btn>

    <v-toolbar-title>Add Maintenance</v-toolbar-title>
  </v-toolbar>
  <div class="form">
    <div class="form-box pt-25">
      <v-form @submit.prevent="submit">
        <v-container>
          <v-select
            v-model="maintenance_schedule.part_id"
            :items="parts"
            item-title="name"
            item-value="id"
            label="Select part"
          >
          </v-select>

          <v-text-field v-model="maintenance_schedule.date" type="date" label="Date"></v-text-field>
          <a
            v-for="month in months"
            :key="month"
            href="#"
            class="btn btn-outline-dark btn-sm m-1"
            @click="completed ? minusMonth(month) : addMonth(month)"
          >
            {{ completed ? '-' : '+' }}{{ month }} month
          </a>

          <v-text-field
            v-model="maintenance_schedule.mileage"
            type="Mileage"
            label="Mileage / Target Mileage"
          ></v-text-field>

          <a href="#" @click="toggleAdvance">{{ advance ? 'Show less' : 'Show advance' }}</a>

          <div v-if="advance">
            <v-text-field
              v-model="maintenance_schedule.price"
              type="number"
              label="Price / Target Price"
            ></v-text-field>

            <v-text-field v-model="maintenance_schedule.note" label="Note"></v-text-field>

            <v-text-field
              v-model="maintenance_schedule.workshop_id"
              label="Workshop"
            ></v-text-field>
          </div>

          <div class="field pb-25">
            <v-btn class="submit btn-primary w-100 m-2" type="submit" name="submit" value="Add"
              >Submit</v-btn
            >
            <v-btn class="btn btn-secondary w-100 m-2" @click="routerBack">Cancel</v-btn>
          </div>
        </v-container>
      </v-form>
    </div>
  </div>
  <Loading ref="LoadingOverlay" :close-ov="closeOv" />
</template>
<script>
import { useRouter } from 'vue-router';
import axios from 'axios';
import { showToast } from '@/utils/showToast';
import Loading from '@/pages/panel/util/Loading.vue';
import { LoadingMix } from '@/pages/panel/util/LoadingMix';

const router = useRouter();
export default {
  name: 'App',
  components: { Loading },
  mixins: [LoadingMix],
  data() {
    return {
      months: ['1', '3', '6', '12', '24'],
      completed: this.$router.currentRoute.value.params.status === 'completed',
      advance: false,
      maintenance_schedule: {
        part_id: '',
        date: new Date().toISOString().split('T')[0],
        status: '',
        note: '',
        mileage: '',
        price: '',
        workshop_id: '',
      },
      parts: [],
    };
  },
  async mounted() {
    this.openOv('LoadingOverlay');
    const part_result = await axios.get('/api/v1/parts/');
    this.parts = part_result.data;
    const status = this.$router.currentRoute.value.params.status;
    console.log(status);
    this.maintenance_schedule.status = status;
    this.closeOv('LoadingOverlay');
  },
  methods: {
    addMonth(month) {
      this.maintenance_schedule.date = new Date(this.maintenance_schedule.date);
      this.maintenance_schedule.date.setMonth(
        this.maintenance_schedule.date.getMonth() + parseInt(month),
      );
      this.maintenance_schedule.date = this.maintenance_schedule.date.toISOString().split('T')[0];
    },
    minusMonth(month) {
      this.maintenance_schedule.date = new Date(this.maintenance_schedule.date);
      this.maintenance_schedule.date.setMonth(
        this.maintenance_schedule.date.getMonth() - parseInt(month),
      );
      this.maintenance_schedule.date = this.maintenance_schedule.date.toISOString().split('T')[0];
    },
    toggleAdvance(e) {
      this.advance = !this.advance;
      e.preventDefault();
    },
    routerBack(e) {
      e.preventDefault();
      this.$router.go(-1);
    },
    submit() {
      this.openOv('LoadingOverlay');
      const vehicleId = this.$router.currentRoute.value.params.vehicle_id;
      const formData = new FormData();
      formData.append('part_id', this.maintenance_schedule.part_id);
      console.log(this.maintenance_schedule.date);
      formData.append('date', this.maintenance_schedule.date);
      formData.append('status', this.maintenance_schedule.status);
      formData.append('note', this.maintenance_schedule.note);
      formData.append('mileage', this.maintenance_schedule.mileage);
      formData.append('price', this.maintenance_schedule.price);
      formData.append('workshop_id', this.maintenance_schedule.workshop_id);
      axios
        .post('/api/v1/vehicles/' + vehicleId + '/maintenance_schedules', formData, {})
        .then(() => {
          this.$router.push({ name: 'maintenanceSchedules', params: { vehicle_id: vehicleId } });
          this.closeOv('LoadingOverlay');
          showToast('Maintenance Schedule Added', 'success');
        })
        .catch((error) => {
          console.log(error);
          this.closeOv('LoadingOverlay');
          showToast(error.response.data.errors[0], 'error');
        });
    },
  },
};
</script>
