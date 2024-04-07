<template>
  <h2 class="text-center">Welcome to SEVOTI</h2>
  <h4 class="text-center">Service on time</h4>
  <div>
    <img :src="imgUrl" class="w-100" alt="" />

    <p>Perkhidmatan peringatan penyelenggaraan kereta dapat sangat membantu dalam beberapa cara:</p>

    <p>
      1. Mengingatkan Jadual Penyelenggaraan: Perkhidmatan peringatan ini akan menghantar peringatan
      kepada anda apabila tiba masanya untuk menjalankan penyelenggaraan rutin seperti menukar
      minyak enjin, memeriksa tayar, dan lain-lain.
    </p>
    <p>
      2. Mencegah Kerosakan: Dengan peringatan yang betul, anda dapat mencegah kerosakan yang
      mungkin berlaku jika penyelenggaraan diabaikan. Ini boleh menjimatkan anda daripada kos
      pembaikan yang mahal.
    </p>
    <p>
      3. Memanjangkan Jangka Hayat Kereta: Penyelenggaraan yang betul dan tepat pada masanya dapat
      memanjangkan jangka hayat kereta anda, dan perkhidmatan peringatan ini memastikan anda tidak
      melewatkan sebarang penyelenggaraan penting.
    </p>
    <p>
      4. Menjimatkan Masa dan Usaha: Anda tidak perlu mengingat jadual penyelenggaraan kereta anda;
      perkhidmatan peringatan akan melakukan itu untuk anda.
    </p>
    <p>
      5. Menjaga Nilai Kenderaan: Kereta yang diselenggara dengan baik akan mempertahankan nilai
      jual semula yang lebih baik.
    </p>
    <p>
      6. Keselamatan: Penyelenggaraan kereta yang tepat pada masanya juga penting untuk keselamatan
      anda dan penumpang lain di dalam kereta.
    </p>

    <p>
      Perkhidmatan peringatan penyelenggaraan kereta adalah alat yang sangat berharga untuk
      memastikan kereta anda mendapat penjagaan yang ia perlukan. Harap ini membantu! Jika ada
      pertanyaan lain, jangan ragu untuk bertanya.
    </p>
  </div>
  <div class="m-3">
    <router-link to="login" class="btn btn-primary w-100">Login</router-link>
  </div>
  <div class="m-3">
    <router-link to="signup" class="btn btn-primary w-100">Sign Up</router-link>
  </div>
</template>

<script setup lang="ts">
// eslint-disable-next-line import/no-unresolved
import imgUrl from '/assets/hero.png';
const pageName = 'Index';
</script>
