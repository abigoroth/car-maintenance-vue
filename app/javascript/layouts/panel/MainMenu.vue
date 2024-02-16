<template>
  <footer>
    <nav class="mobile-nav">
      <router-link :to="{ name: 'index' }" class="bloc-icon" :class="isActive('')">
        Upcoming
        <span class="material-symbols-outlined"> handyman </span>
      </router-link>
      <router-link :to="{ name: 'vehicles' }" class="bloc-icon" :class="isActive('vehicles')">
        Vehicle
        <span class="material-symbols-outlined"> transportation </span>
      </router-link>

      <router-link :to="{ name: 'contact' }" class="bloc-icon" :class="isActive('contact')">
        Utility
        <span class="material-symbols-outlined"> contact_support </span>
      </router-link>
    </nav>
  </footer>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter();

function isActive(path: string) {
  return router.currentRoute.value.path == '/' + path ? 'active' : 'item';
}
</script>
