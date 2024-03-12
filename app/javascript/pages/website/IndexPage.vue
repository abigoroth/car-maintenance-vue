<template>
  <h2 class="text-center">Welcome to SEVOTI</h2>
  <h4 class="text-center">Service on time</h4>
  <div>
    <img :src="imgUrl" class="w-100" alt="" />
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
