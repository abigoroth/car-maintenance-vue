<template>
  <BaseLayout>
    <div class="wrapper">
      <div class="section bg-white">
        <div class="container">
          <router-view />
        </div>
      </div>
      <MainMenu />
    </div>
  </BaseLayout>
</template>

<script setup lang="ts">
import BaseLayout from '../BaseLayout.vue';
import MainMenu from './MainMenu.vue';
</script>
