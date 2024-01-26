<template>
  <div class="form">
    <div class="form-box pt-25">
      <div class="form-bg py-30 px-50">
        <form @submit.prevent="submit">
          <div class="field pb-25">
            <label for="make">Make</label>
            <input v-model="vehicle.make" type="make" placeholder="Proton" />
          </div>

          <div class="field pb-25">
            <label for="model">Model</label>
            <input v-model="vehicle.model" type="text" placeholder="Persona" />
          </div>

          <div class="field pb-25">
            <label for="year">Year</label>
            <input v-model="vehicle.year" type="number" />
          </div>

          <div class="field pb-25">
            <label for="mileage">Mileage</label>
            <input v-model="vehicle.mileage" type="number" />
          </div>

          <div class="field pb-25">
            <label for="mileage">Plate Number</label>
            <input v-model="vehicle.plate_number" type="text" />
          </div>

          <div class="field pb-25">
            <label for="vin_number">vin_number</label>
            <input v-model="vehicle.vin_number" type="vin_number" />
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
<script setup lang="ts">
import { useRouter } from 'vue-router';
import axios from 'axios';
import { showToast } from '@/utils/showToast';

const router = useRouter();

type Vehicle = {
  make: string;
  model: string;
  year: number | null;
  plate_number: string;
  vin_number: string;
  mileage: number;
};
const vehicle: Vehicle = {
  make: '',
  model: '',
  year: null,
  vin_number: '',
  mileage: 0,
  plate_number: '',
};
const submit = () => {
  const formData = new FormData();
  formData.append('make', vehicle.make);
  formData.append('model', vehicle.model);
  formData.append('year', vehicle.year.toString());
  formData.append('vin_number', vehicle.vin_number);
  formData.append('plate_number', vehicle.plate_number);
  formData.append('mileage', vehicle.mileage.toString());

  axios
    .post('/api/v1/vehicles', formData, {})
    .then(() => {
      router.push({ name: 'vehicles' });
    })
    .catch((error) => {
      console.log(error.response.data.errors);
      showToast(error.response.data.errors[0], 'error');
    });
};
</script>
