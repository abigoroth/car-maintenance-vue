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
          </div>
          <div class="field pb-25">
            <label for="mileage">Target Mileage</label>
            <input v-model="maintenance_schedule.target_mileage" type="number" />
          </div>
          <div class="field pb-25">
            <label for="mileage">Note</label>
            <input v-model="maintenance_schedule.note" type="text" />
          </div>

          <div class="field pb-25">
            <label for="vin_number">Workshop</label>
            <input v-model="maintenance_schedule.workshop_id" />
          </div>

          <div class="field pb-25">
            <input class="submit" type="submit" name="submit" value="Add" />
            <button class="btn btn-secondary w-100 p-2 mt-2" @click="$router.go(-1)">Cancel</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>
<script>
import { useRouter } from 'vue-router';
import axios from 'axios';
import { showToast } from '@/utils/showToast';

const router = useRouter();
export default {
  name: 'App',
  data() {
    return {
      maintenance_schedule: {
        part_id: '',
        date: '',
        status: '',
        note: '',
        target_mileage: '',
        workshop_id: '',
      },
      parts: [],
    };
  },
  async mounted() {
    const part_result = await axios.get('/api/v1/parts/');
    this.parts = part_result.data;
  },
  methods: {
    submit() {
      const vehicleId = this.$router.currentRoute.value.params.vehicle_id;
      const formData = new FormData();
      formData.append('part_id', this.maintenance_schedule.part_id);
      console.log(this.maintenance_schedule.date);
      formData.append('date', this.maintenance_schedule.date);
      formData.append('status', this.maintenance_schedule.status);
      formData.append('note', this.maintenance_schedule.note);
      formData.append('target_mileage', this.maintenance_schedule.target_mileage);
      formData.append('workshop_id', this.maintenance_schedule.workshop_id);
      axios
        .post('/api/v1/vehicles/' + vehicleId + '/maintenance_schedules', formData, {})
        .then(() => {
          this.$router.push({ name: 'maintenanceSchedules', params: { vehicle_id: vehicleId } });
          showToast('Maintenance Schedule Added', 'success');
        })
        .catch((error) => {
          console.log(error);
          showToast(error.response.data.errors[0], 'error');
        });
    },
  },
};
</script>
