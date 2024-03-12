<template>
  <h2 class="text-center">Contact</h2>
  <ul class="navbar-nav">
    <li class="nav-item">
      <a
        href="https://wa.me/60172931521?text=Sevoti+Help"
        target="_blank"
        class="btn btn-primary d-flex"
      >
        Whatsapp
      </a>
    </li>
    <li class="nav-item btn btn-danger" @click="requestPermission">Notification</li>
    <li class="nav-item btn btn-danger" @click="getOsId">getOsId</li>
    <li class="nav-item btn btn-danger" @click="logout">Logout</li>
  </ul>
</template>
<script>
import axios from 'axios';
import { createRouter as OneSignal } from 'vue-router';
import { useAuthStore } from '@/stores/auth.store';
import { showToast } from '@/utils/showToast';
const authStore = useAuthStore();
// import OneSignalVuePlugin from '@onesignal/onesignal-vue3';

const logout = () => {
  authStore.logout();
};

function requestPermission() {
  console.log('Requesting permission...');
  Notification.requestPermission().then((permission) => {
    if (permission === 'granted') {
      const granted_msg = 'Notification permission granted.';
      console.log(granted_msg);
      alert(granted_msg);
    } else {
      alert('Permission: ' + permission);
    }
  });
}

export default {
  name: 'App',
  methods: {
    async getOsId() {
      const os_sub_id = localStorage.getItem('os_sub_id');
      const os_app_id = localStorage.getItem('os_app_id');
      const userId = localStorage.getItem('userId');
      const os_id = localStorage.getItem('os_id');
      console.log(id);
      localStorage.setItem('os_id', os_id);
      console.log(authStore);

      // might not be using createOsUser. To be deleted.
      // const createOsUser = await axios.post(
      //   'https://api.onesignal.com/apps/' +
      //   os_app_id +
      //   '/users',
      //   { identity: { external_id: userId, onesignal_id: os_id } })
      //   .then((result) => {
      //     console.log(result);
      //   });

      // delete
      // await axios.delete('https://api.onesignal.com/apps/' + os_app_id + '/users/by/external_id/1');
      // send notification hapily.. :P
      // https://documentation.onesignal.com/reference/create-alias-by-subscription
    },
  },
};
</script>
