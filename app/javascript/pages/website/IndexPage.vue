<template>
  <h2 class="text-center">Welcome to SERVOTI</h2>
  <h4 class="text-center">Service on time</h4>
  <div>
    <img src="hero.png" class="w-100" alt="" />
  </div>
  <div class="m-3">
    <router-link to="login" class="btn btn-primary w-100">Login</router-link>
  </div>
  <div class="m-3">
    <router-link to="signup" class="btn btn-primary w-100">Sign Up</router-link>
  </div>
</template>

<script setup lang="ts">
const pageName = 'Index';
</script>
