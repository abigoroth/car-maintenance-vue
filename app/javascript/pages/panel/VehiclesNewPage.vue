<template>
  <div class="form">
    <div class="form-box pt-25">
      <div class="form-bg py-30 px-50">
        <form @submit.prevent="submit">
          <div class="field pb-25">
            <label for="make">Make</label>
            <input v-model="vehicle.make" type="text" placeholder="" />
            <a
              v-for="makeSelector in makes"
              :key="makeSelector"
              href="#"
              class="btn btn-outline-dark btn-sm m-1"
              @click="setMake(makeSelector)"
            >
              {{ makeSelector }}
            </a>
            <select v-model="vehicle.make">
              <option value="" disabled selected>SELECT OTHER</option>
              <option v-for="makeSelector in otherMakes" :key="makeSelector" :value="makeSelector">
                {{ makeSelector }}
              </option>
            </select>
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
<script>
import axios from 'axios';
import { showToast } from '@/utils/showToast';
export default {
  name: 'App',
  data() {
    return {
      vehicle: {
        make: '',
        model: '',
        year: '',
        vin_number: '',
        mileage: '',
        plate_number: '',
      },
      vehicles: [],
      makes: ['Toyota', 'Perodua', 'Honda', 'Mercedes', 'Nissan', 'BMW'],
      otherMakes: [
        'AC',
        'ALFA ROMEO',
        'ALPINE',
        'ASIA MOTORS',
        'ARIEL',
        'ASTON MARTIN',
        'AUDI',
        'AUSTIN',
        'BBAW',
        'BENTLEY',
        'BISON',
        'BMW',
        'BOON KOON',
        'BORGWARD',
        'BRABUS',
        'BUFORI',
        'BUGATTI',
        'BYD',
        'BUICK',
        'CCADILLAC',
        'CAM',
        'CATERHAM',
        'CHANA',
        'CHANGAN',
        'CHERY',
        'CHEVROLET',
        'CHRYSLER',
        'CITROEN',
        'DDAEWOO',
        'DAIHATSU',
        'DAIMLER',
        'DATSUN',
        'DODGE',
        'DONGFENG',
        'DS AUTOMOBILES',
        'DURANT',
        'EEXCALIBUR',
        'FFACTORY FIVE',
        'FARID',
        'FERRARI',
        'FIAT',
        'FODAY',
        'FORD',
        'FOTON',
        'GGAC',
        'GMC',
        'GOLDEN DRAGON',
        'GREAT WALL',
        'HHAVAL',
        'HOLDEN',
        'HONDA',
        'HUANGHAI',
        'HUMMER',
        'HYUNDAI',
        'IINFINITI',
        'INOKOM',
        'ISUZU',
        'IVECO',
        'JJAGUAR',
        'JEEP',
        'JMC',
        'JOYLONG',
        'KKAICENE',
        'KIA',
        'KING LONG',
        'KTM',
        'LLAMBORGHINI',
        'LANCIA',
        'LAND ROVER',
        'LEXUS',
        'LINCOLN',
        'LMG',
        'LOTUS',
        'MMAHINDRA',
        'MASERATI',
        'MAXUS',
        'MAZDA',
        'MCLAREN',
        'MERCEDES BENZ',
        'MG',
        'MINI',
        'MITSUBISHI',
        'MITSUOKA',
        'MORGAN',
        'MORRIS',
        'NNAZA',
        'NETA',
        'NISSAN',
        'OOLDSMOBILE',
        'OPEL',
        'OTHERS',
        'PPANTHER',
        'PERODUA',
        'PEUGEOT',
        'PONTIAC',
        'PORSCHE',
        'PROTON',
        'RRENAULT',
        'ROLLS-ROYCE',
        'ROVER',
        'SSAAB',
        'SHELBY',
        'SHENYANG BRILLIANCE',
        'SKODA',
        'SMART',
        'SSANGYONG',
        'SUBARU',
        'SUNBEAM',
        'SUTTON',
        'SUZUKI',
        'TTATA',
        'TD2000',
        'TESLA',
        'TOYOTA',
        'TRIUMPH',
        'TVR',
        'VVOLKSWAGEN',
        'VOLVO',
        'WWESTSTAR',
        'WOLSELEY',
        'YYANGTSE',
        'ZZENVO',
        'ZNA',
        'ZXAUTO',
      ],
    };
  },
  methods: {
    setMake(make) {
      this.vehicle.make = make;
    },
    submit() {
      const formData = new FormData();
      formData.append('make', vehicle.make);
      formData.append('model', vehicle.model);
      formData.append('year', vehicle.year);
      formData.append('vin_number', vehicle.vin_number);
      formData.append('plate_number', vehicle.plate_number);
      formData.append('mileage', vehicle.mileage);
      axios
        .post('/api/v1/vehicles', formData, {})
        .then(() => {
          router.push({ name: 'vehicles' });
        })
        .catch((error) => {
          console.log(error.response.data.errors);
          showToast(error.response.data.errors[0], 'error');
        });
    },
  },
};
</script>
