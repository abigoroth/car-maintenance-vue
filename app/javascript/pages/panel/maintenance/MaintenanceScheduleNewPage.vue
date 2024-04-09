<template>
  <div class="form">
    <div class="form-box pt-25">
      <div class="form-bg py-30 px-50">
        <form @submit.prevent="submit">
          <div class="field pb-25">
            <label for="make">Part</label>
            <select v-model="maintenance_schedule.part_id">
              <option v-for="part in parts" :key="part.id" :value="part.id">
                {{ part.name }}
              </option>
            </select>
          </div>

          <div class="field pb-25">
            <label for="date">Date</label>
            <input v-model="maintenance_schedule.date" type="date" />
            <a
              v-for="month in months"
              :key="month"
              href="#"
              class="btn btn-outline-dark btn-sm m-1"
              @click="completed ? minusMonth(month) : addMonth(month)"
            >
              {{ completed ? '-' : '+' }}{{ month }} month
            </a>
          </div>
          <div class="field pb-25">
            <label for="mileage">{{
              maintenance_schedule.status === 'completed' ? 'Mileage' : 'Target Mileage'
            }}</label>
            <input v-model="maintenance_schedule.mileage" type="number" />
          </div>

          <a href="#" class="mb-2" @click="toggleAdvance">{{
            advance ? 'Show less' : 'Show advance'
          }}</a>

          <div v-if="advance">
            <div class="field pb-25">
              <label for="vin_number">{{ completed ? 'Price' : 'Target Price' }}</label>
              <input v-model="maintenance_schedule.price" type="number" />
            </div>

            <div class="field pb-25">
              <label for="mileage">Note</label>
              <input v-model="maintenance_schedule.note" type="text" />
            </div>

            <div class="field pb-25">
              <label for="vin_number">Workshop</label>
              <input v-model="maintenance_schedule.workshop_id" />
            </div>
          </div>

          <div class="field pb-25 pt-2">
            <input class="submit" type="submit" name="submit" value="Add" />
            <button class="btn btn-secondary w-100 p-2 mt-2" @click="routerBack">Cancel</button>
          </div>
        </form>
      </div>
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
