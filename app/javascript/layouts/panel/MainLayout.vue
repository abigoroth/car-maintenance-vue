<template>
  <BaseLayout>
    <div class="wrapper">
      <div class="section bg-white">
        <div class="container" style="margin-bottom: 70px">
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
