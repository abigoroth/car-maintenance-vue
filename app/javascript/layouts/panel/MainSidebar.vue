<template>
  <nav>
    <div class="profile">
      <img
        src="https://upload.wikimedia.org/wikipedia/commons/6/62/Ruby_On_Rails_Logo.svg"
        alt="profile_picture"
      />
      <h3>Ruby on Rails</h3>
      <p>Vue.js</p>
    </div>
    <ul>
      <li :class="isActive('')">
        <router-link
          :to="{
            name: 'index',
          }"
          class="item"
        >
          My Dashboard
        </router-link>
      </li>
      <li :class="isActive('vehicles')">
        <router-link :to="{ name: 'vehicles' }" class="item"> Vehicle </router-link>
      </li>
    </ul>
  </nav>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router';
const router = useRouter();

function isActive(path: string) {
  return router.currentRoute.value.path == '/' + path ? 'active' : 'item';
}
</script>
