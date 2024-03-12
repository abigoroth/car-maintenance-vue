<template>
  <div class="form">
    <div class="form-box pt-25">
      <div class="form-bg py-30 px-50">
        <form @submit.prevent="submit">
          <div class="field pb-25">
            <label for="make">Make</label>
            <br />
            <a
              v-for="makeSelector in makes"
              :key="makeSelector"
              href="#"
              class="btn btn-outline-dark btn-sm m-1"
              :class="{ active: vehicle.make === makeSelector }"
              @click="setMake(makeSelector)"
            >
              {{ makeSelector }}
            </a>
            <select v-model="vehicle.make" @change="makeChange">
              <option value="" disabled selected>SELECT MAKER</option>
              <option v-for="makeSelector in otherMakes" :key="makeSelector" :value="makeSelector">
                {{ makeSelector }}
              </option>
            </select>
          </div>

          <div class="field pb-25">
            <label for="model">Model</label>
            <br />
            <select v-model="vehicle.model">
              <option value="" disabled selected>SELECT MODEL</option>
              <option v-for="modelSelector in models" :key="modelSelector" :value="modelSelector">
                {{ modelSelector }}
              </option>
            </select>
          </div>

          <div class="field pb-25">
            <label for="mileage">Plate Number</label>
            <input v-model="vehicle.plate_number" type="text" />
          </div>

          <a href="#" @click="toggleAdvance">{{ advanceText }}</a>

          <div v-if="advance">
            <div class="field pb-25">
              <label for="year">Year</label>
              <input v-model="vehicle.year" type="number" />
            </div>

            <div class="field pb-25">
              <label for="mileage">Mileage</label>
              <input v-model="vehicle.mileage" type="number" />
            </div>

            <div class="field pb-25">
              <label for="vin_number">vin_number</label>
              <input v-model="vehicle.vin_number" type="vin_number" />
            </div>
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
import axios from 'axios';
import { allMakes, allModels, getModels } from 'malaysian-cars';
import { showToast } from '@/utils/showToast';
export default {
  name: 'App',
  data() {
    return {
      advance: false,
      advanceText: 'Show advance',
      vehicle: {
        make: '',
        model: '',
        year: '',
        vin_number: '',
        mileage: '',
        plate_number: '',
      },
      vehicles: [],
      makes: ['Proton', 'Perodua', 'Honda', 'Toyota', 'Nissan', 'BMW'],
      otherMakes: allMakes.map((x) => x.name),
      models: [],
    };
  },
  methods: {
    toggleAdvance(e) {
      this.advance = !this.advance;
      this.advance ? (this.advanceText = 'Show less') : (this.advanceText = 'Show advance');
      e.preventDefault();
    },
    makeChange(event) {
      const make = event.target.value;
      this.models = getModels(make);
    },
    setMake(make) {
      this.vehicle.make = make;
      // this.filterModel(make);
      this.models = getModels(make);
    },
    submit() {
      const formData = new FormData();
      formData.append('make', this.vehicle.make);
      formData.append('model', this.vehicle.model);
      formData.append('year', this.vehicle.year);
      formData.append('vin_number', this.vehicle.vin_number);
      formData.append('plate_number', this.vehicle.plate_number);
      formData.append('mileage', this.vehicle.mileage);
      axios
        .post('/api/v1/vehicles', formData, {})
        .then(() => {
          this.$router.push({ name: 'vehicles' });
        })
        .catch((error) => {
          console.log(error.response.data.errors);
          showToast(error.response.data.errors[0], 'error');
        });
    },
  },
};
</script>
